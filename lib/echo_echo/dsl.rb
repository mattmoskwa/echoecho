module EchoEcho
  module DSL
    module ClassMethods

      klass = nil
      global_args = []
      #scope :global
      define_method :global do |*names|
        global_args += names
      end
      #end scope :global

      # scope :entity
      define_method :entity do |name, &blk|
        cname = name.titlecase
        klass = EchoEcho.const_set cname, Class.new {
          define_singleton_method :resource_name do
            name
          end
        }
        blk.call if blk
      end

      # scope :add_method
      define_method :add_method do |name, &blk|
        _args = []
        callbacks = []

        # open the module because we need to share scope between the following methods
        module_eval do
          # scope :required
          define_singleton_method :required do |*req|
            # extract options from args
            opts_hash = req.extract_options!
            all = req
            any = []
            opts_hash.each do |k,v|
              if k == :any
                any = v
              else
                raise ArgumentError.new "option not supported #{k}"
              end
            end
            callbacks << lambda { |args|
              args = args.keys
              if any.present?
                # some or all of these are required
                unless args.any? {|a| any.member? a}
                  raise ArgumentError.new "missing one or more required arguments #{any}"
                end
              end

              unless all.empty?
                all.each do |r|
                  unless args.member? r
                    raise ArgumentError.new "missing required argument #{r}"
                  end
                end
              end
              _args += (any + all)
            }
          end
          # end scope :requred
          # scope :optional
          define_singleton_method :optional do |*opts|
            callbacks << ->(args) do
              args.keys.each do |a|
                unless opts.concat(_args).concat(global_args).member? a
                  raise ArgumentError.new "#{a} not an accepted option"
                end
              end
            end
          end
          # end scope :optional

          # scope :warn
          define_singleton_method :warn do |warning_label|
            message = EchoEcho.config.warnings[warning_label]
            callbacks << lambda { |args| puts "Warning: #{message}" }
          end
          # end scope :warn

          # scope :multiple
          define_singleton_method :multiple do |*opts|
            # add callbacks to check these arguments for multiple keys
            o = opts.extract_options!
            _args += opts
            o.each do |k,v|
              if !v.is_a? Hash
                raise ArgumentError.new "Unsupported argument type: #{k}:#{v}"
              elsif !v.has_key? :limit
                raise ArgumentError.new "Unsupported argument option: #{v}"
              end
            end
            callbacks << ->(args) do
              # check that only args in opts have multiple values
              args.each do |k,v|
                if v.is_a? Array and v.size > 1
                  if k.in? o.keys
                    unless v.size <= o[k][:limit]
                      raise ArgumentError.new "Paramter #{k} does not accept more than #{o[k][:limit]} values"
                    end
                  elsif !k.in? opts
                    raise ArgumentError.new "Method doesn't accept multiple values for #{k}"
                  end
                end
              end
            end
          end
          # end scope :multiple
        end

        blk.call if blk
        klass.instance_eval do
          define_singleton_method(name) do |options={}|
            callbacks.each {|c| c.call(options)}

            response = Request.new(resource_name).get(options.merge(method: name))
            response.response
          end
        end
      end
      # end scope :add_method
    end
    # end scope :entity
    extend ClassMethods
    def self.included(other)
      other.extend ClassMethods
    end
  end
end
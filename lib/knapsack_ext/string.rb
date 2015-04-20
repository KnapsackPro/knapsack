module KnapsackExt
  class String
    def self.underscore_and_drop_module(class_or_string)
      str = class_or_string.to_s
      str = str.split('::').last
      str = str.gsub(/(.)([A-Z])/,'\1_\2')
      str.downcase
    end
  end
end

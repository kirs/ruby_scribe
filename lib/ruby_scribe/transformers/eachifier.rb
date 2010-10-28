module RubyScribe
  module Transformers
    
    # = For to Each Block Transform
    # Finds instances using "for something in collection"-style of iteration and converts
    # it to using a standard collection.each block.
    #
    # Example:
    #   
    #   for element in collection
    #     do_something(element)
    #   end
    # 
    # Converts To:
    # 
    #   collection.each do |element|
    #     do_something(element)
    #   end
    # 
    class Eachifier < Transformer
      def transform(e)
        if e.is_a?(Sexp) && e.kind == :for
          super transform_for_to_each(e)
        else
          super
        end
      end
      
      def transform_for_to_each(e)
        s(:iter, 
          s(:call, e.body[0], :each, s(:arglist)), 
          e.body[1],
          e.body[2]
        )
      end
    end
    
  end
end
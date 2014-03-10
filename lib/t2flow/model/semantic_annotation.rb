# A representation of a semantic annotation. It is linked to a +subject+,
# which can be a processor, port, or dataflow object. It has a +type+, which
# indicates the MIME type of it's +content+. By default, this will be text/rdf+n3.
# +Content+ is the content of the annotation, which in n3 form consists of one or more
# triples.
module T2Flow
  class SemanticAnnotation
    attr_reader :subject, :type, :content

    def initialize(subject, type, content)
      @subject = subject
      @type = type
      @content = content
    end

    def to_s
      @content
    end
  end
end

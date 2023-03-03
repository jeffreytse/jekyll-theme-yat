module Jekyll
    module AssetFilter
        def to_time(date_string)
            DateTime.parse(date_string).to_time
        end
    end
end

Liquid::Template.register_filter(Jekyll::AssetFilter)

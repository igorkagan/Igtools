function ig_close_childless_figures
%IG_CLOSE_CHILDLESS_FIGURES		- close childless figures

h = get(0,'Children');
if ~isempty(h)
        for k=1:length(h)
                if isempty(get(h(k),'Children'))
                        close(h(k));
                end
        end
end

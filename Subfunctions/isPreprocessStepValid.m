function ISVALID=isPreprocessStepValid(STEPS)
    ISVALID=1;
    steps=STEPS(STEPS<=length(STEPS));
    %all none
    if(length(steps)==0) 
        return;
    end
    %1
    steps_sort=sort(steps);
    steps_sort_uni=unique(steps_sort);
    if(length(steps_sort_uni) ~= length(steps_sort))
        ISVALID=0;
    end
    if(min(steps_sort_uni)~=1 || max(steps_sort_uni) ~= length(steps_sort_uni))
        ISVALID=0;
    end
end
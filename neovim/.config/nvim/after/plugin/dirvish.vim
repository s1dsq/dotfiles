if !exists('g:loaded_dirvish')
    finish
endif

call dirvish#add_icon_fn({p -> p[-1:]=='/'?'📂':'📄'})

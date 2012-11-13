NAME=index
python rst-directive.py \
    --stylesheet=pygments.css \
    --theme-url=ui/loogica \
    ${NAME}.rst > ${NAME}.html

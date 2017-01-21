if (window.Zepto) {
    jQuery = Zepto;
    (function ($) {
        if ($) {
            $.fn.prop = $.fn.attr;
        }
    }(jQuery));
}

$(document).ready(function () {

    var $statelist, $SLmap, ratio,
            mapsterConfigured = function () {
                // set html settings values
                var opts = $SLmap.mapster('get_options', null, true);
                if (!ratio) {
                    ratio = $SLmap.width() / $SLmap.height();
                }
                $('#stroke_highlight').prop("checked", opts.render_highlight.stroke);
                $('#strokewidth_highlight').val(opts.render_highlight.strokeWidth);
                $('#fill_highlight').val(opts.render_highlight.fillOpacity);
                $('#strokeopacity_highlight').val(opts.render_highlight.strokeOpacity);
                $('#stroke_select').prop("checked", opts.render_select.stroke);
                $('#strokewidth_select').val(opts.render_select.strokeWidth);
                $('#fill_select').val(opts.render_select.fillOpacity);
                $('#strokeopacity_select').val(opts.render_select.strokeOpacity);
                $('#mouseout-delay').val(opts.mouseoutDelay);
                $('#img_width').val($SLmap.width());
            },
            default_options =
            {
                fillOpacity: 0.5,
                render_highlight: {
                    fillColor: 'ffffff',
                    stroke: false
                },
                render_select: {
                    fillColor: '002A6C',
                    stroke: false
                },
                mouseoutDelay: 0,
                fadeInterval: 50,
                isSelectable: true,
                singleSelect: false,
                mapKey: 'state',
                mapValue: 'full',
                listKey: 'name',
                listSelectedAttribute: 'checked',
                sortList: "asc",
                onGetList: addCheckBoxes,
                onConfigured: mapsterConfigured,
                showToolTip: true,
                toolTipClose: ["area-mouseout"],
                areas: [
                    {key: "Ampara",
                        toolTip: "Ampara"

                    },
                    {key: "Jaffna",
                        toolTip: "Jaffna"

                    },
                    {key: "Vavuniya",
                        toolTip: "Vavuniya"

                    },
                    {key: "Kilinochchi",
                        toolTip: "Kilinochchi"

                    }
                    ,
                    {key: "Mullativu",
                        toolTip: "Mullativu"

                    }
                    ,
                    {key: "Mannar",
                        toolTip: "Mannar"

                    }
                    ,
                    {key: "Anuradhapura",
                        toolTip: "Anuradhapura"

                    }
                    ,
                    {key: "Trincomalee",
                        toolTip: "Trincomalee"

                    }
                    ,
                    {key: "Puttalam",
                        toolTip: "Puttalam"

                    }
                    ,
                    {key: "Kurunegala",
                        toolTip: "Kurunegala"

                    }
                    ,
                    {key: "Matale",
                        toolTip: "Matale"

                    }
                    ,
                    {key: "Polonnaruwa",
                        toolTip: "Polonnaruwa"

                    }
                    ,
                    {key: "Batticaloa",
                        toolTip: "Batticaloa"

                    }
                    ,
                    {key: "Kalutara",
                        toolTip: "Kalutara"

                    }
                    ,
                    {key: "Gampaha",
                        toolTip: "Gampaha"

                    }
                    ,
                    {key: "Colombo",
                        toolTip: "Colombo"

                    }
                    ,
                    {key: "Kegalle",
                        toolTip: "Kegalle"

                    }
                    ,
                    {key: "Kandy",
                        toolTip: "Kandy"

                    }
                    ,
                    {key: "Badulla",
                        toolTip: "Badulla"

                    }
                    ,
                    {key: "Nuwara Eliya",
                        toolTip: "Nuwara Eliya"

                    }
                    ,
                    {key: "Ratnapura",
                        toolTip: "Ratnapura"

                    }
                    ,
                    {key: "Moneragala",
                        toolTip: "Moneragala"

                    }
                    ,
                    {key: "Hambantota",
                        toolTip: "Hambantota"

                    }
                    ,
                    {key: "Matara",
                        toolTip: "Matara"

                    }
                    ,
                    {key: "Galle",
                        toolTip: "Galle"

                    }


                ]

            };



    function styleCheckbox(selected, $checkbox) {
        var nowWeight = selected ? "normal" : "normal";
        $checkbox.closest('div').css("font-weight", nowWeight);
    }

    function addCheckBoxes(items) {
        var item, selected;
        $statelist.children().remove();



        item = $('<div class="col-lg-6">\n'
                + '<div><input id=' + 0 + ' type="checkbox"  name="' + items[0].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[0].key + '">' + items[0].value + '</span></div>\n'
                + '<div><input id=' + 1 + ' type="checkbox"  name="' + items[1].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[1].key + '">' + items[1].value + '</span></div>\n'
                + '<div><input id=' + 2 + ' type="checkbox"  name="' + items[2].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[2].key + '">' + items[2].value + '</span></div>\n'
                + '<div><input id=' + 3 + ' type="checkbox"  name="' + items[3].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[3].key + '">' + items[3].value + '</span></div>\n'
                + '<div><input id=' + 4 + ' type="checkbox"  name="' + items[4].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[4].key + '">' + items[4].value + '</span></div>\n'
                + '<div><input id=' + 5 + ' type="checkbox"  name="' + items[5].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[5].key + '">' + items[5].value + '</span></div>\n'
                + '<div><input id=' + 6 + ' type="checkbox"  name="' + items[6].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[6].key + '">' + items[6].value + '</span></div>\n'
                + '<div><input id=' + 7 + ' type="checkbox"  name="' + items[7].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[7].key + '">' + items[7].value + '</span></div>\n'
                + '<div><input id=' + 8 + ' type="checkbox"  name="' + items[8].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[8].key + '">' + items[8].value + '</span></div>\n'
                + '<div><input id=' + 9 + ' type="checkbox"  name="' + items[9].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[9].key + '">' + items[9].value + '</span></div>\n'
                + '<div><input id=' + 10 + ' type="checkbox"  name="' + items[10].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[10].key + '">' + items[10].value + '</span></div>\n'
                + '<div><input id=' + 11 + ' type="checkbox"  name="' + items[11].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[11].key + '">' + items[11].value + '</span></div>\n'
                + '<div><input id=' + 12 + ' type="checkbox"  name="' + items[12].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[12].key + '">' + items[12].value + '</span></div>\n'
                
                + '</div>\n'
                + '<div class="col-lg-6">\n'
                + '<div><input id=' + 13 + ' type="checkbox"  name="' + items[13].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[13].key + '">' + items[13].value + '</span></div>\n'
                + '<div><input id=' + 14 + ' type="checkbox"  name="' + items[14].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[14].key + '">' + items[14].value + '</span></div>\n'
                + '<div><input id=' + 15 + ' type="checkbox"  name="' + items[15].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[15].key + '">' + items[15].value + '</span></div>\n'
                + '<div><input id=' + 16 + ' type="checkbox"  name="' + items[16].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[16].key + '">' + items[16].value + '</span></div>\n'
                + '<div><input id=' + 17 + ' type="checkbox"  name="' + items[17].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[17].key + '">' + items[17].value + '</span></div>\n'
                + '<div><input id=' + 18 + ' type="checkbox"  name="' + items[18].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[18].key + '">' + items[18].value + '</span></div>\n'
                + '<div><input id=' + 19 + ' type="checkbox"  name="' + items[19].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[19].key + '">' + items[19].value + '</span></div>\n'
                + '<div><input id=' + 20 + ' type="checkbox"  name="' + items[20].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[20].key + '">' + items[20].value + '</span></div>\n'
                + '<div><input id=' + 21 + ' type="checkbox"  name="' + items[21].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[21].key + '">' + items[21].value + '</span></div>\n'
                + '<div><input id=' + 22 + ' type="checkbox"  name="' + items[22].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[22].key + '">' + items[22].value + '</span></div>\n'
                + '<div><input id=' + 23 + ' type="checkbox"  name="' + items[23].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[23].key + '">' + items[23].value + '</span></div>\n'
                + '<div><input id=' + 24 + ' type="checkbox"  name="' + items[24].key + '"' + (selected ? "checked" : "") + '><span class="sel" key="' + items[24].key + '">' + items[24].value + '</span></div>\n'
                + '</div>\n'

                );

        $statelist.append(item);



        $statelist.find('span.sel').unbind('click').bind('click', function (e) {
            var key = $(this).attr('key');
            $SLmap.mapster('highlight', true, key);
        });
        // return the list to mapster so it can bind to it
        return $statelist.find('input[type="checkbox"]').unbind('click').click(function (e) {
            var selected = $(this).is(':checked');
            $SLmap.mapster('set', selected, $(this).attr('name'));
            styleCheckbox(selected, $(this));
        });
    }


    $statelist = $('#statelist');
    $SLmap = $('#SL_image');
    function bindlinks() {

        function getSelected(sel) {
            var item = $();
            sel.each(function () {
                if (this.selected) {
                    item = item.add(this);
                    return false;
                }

            });
            return item;

        }




    }

    bindlinks();

    $SLmap.mapster(default_options);


});



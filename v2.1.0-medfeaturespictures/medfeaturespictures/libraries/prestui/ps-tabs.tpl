{*
*	The MIT License (MIT)
*
*	Copyright (c) 2015-2017 Emmanuel MARICHAL
*
*	Permission is hereby granted, free of charge, to any person obtaining a copy
*	of this software and associated documentation files (the "Software"), to deal
*	in the Software without restriction, including without limitation the rights
*	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*	copies of the Software, and to permit persons to whom the Software is
*	furnished to do so, subject to the following conditions:
*
*	The above copyright notice and this permission notice shall be included in
*	all copies or substantial portions of the Software.
*
*	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
*	THE SOFTWARE.
*}

<script type="riot/tag">

    <ps-tab>

        <ps-panel if={ opts.panel != 'false' } icon="{ this.icon }"  header="{ this.header }" flag="{ opts.flag }" img="{ opts.img }" fa="{ opts.fa }">
            <yield/>
        </ps-panel>

        <div if={ opts.panel == 'false' }>
            <yield />
        </div>

        <style scoped>

            .panel {
                border-top-left-radius: 0 !important;
                border-top-right-radius: 0 !important;
            }

        </style>

        if (this.parent && this.parent.opts.position != 'top') {
            this.header = opts.label;
            this.icon = opts.icon;
        }
        $(this.root).addClass('tab-pane')
        if (this.opts.active == 'true')
            $(this.root).addClass('active')

    </ps-tab>

</script>

<script type="riot/tag">

  <ps-tabs>

        <div class="row">

            <div class="{ col-md-2: this.opts.position == 'left', col-md-12: this.opts.position != 'left' }" if={ this.displaytabs }>
                <ul class="{ nav: true, list-group: this.opts.position == 'left', nav-tabs: this.opts.position != 'left' }">
                    <li class="{ list-group-item: this.parent.opts.position == 'left', active: tab.opts.active == 'true' }" each={ tab in this.tabs }>
                        <a href="#{ tab.opts.id }" data-toggle="tab" title="{ tab.opts.label }"><img src="{ tab.opts.flag }" if={ tab.opts.flag }> <i class="{ tab.opts.icon } icon-fw" if={ tab.opts.icon }></i> <span class="{ flaglabel: tab.opts.flag }">{ tab.opts.label }</span> <span if={ tab.opts.badge } class="badge pull-right">{ tab.opts.badge }</span></a>
                    </li>
                </ul>
            </div>

            <div class="{ tab-content: true, col-md-10: this.opts.position == 'left', col-md-12: this.opts.position != 'left' }">
                <yield/>
            </div>

            <div class="clearfix"></div>
        </div>

        this.on('mount', function() {
            this.tabs = this.tags['ps-tab'];
            if (this.tabs.length > 1) {
                this.displaytabs = true;
            } else {
                this.displaytabs = false;
            }
            this.update();
        })

        <style scoped>

            li.list-group-item {
                padding: 0 !important;
            }

            li.list-group-item a {
                color: #555;
            }

            li.list-group-item:hover {
                background-color: #f5f5f5;
            }

            li.list-group-item.active a {
                color: white;
            }

            .nav.list-group li a {
                text-overflow: ellipsis;
                white-space: nowrap;
                overflow: hidden;
            }

            .nav li a .badge {
                margin-top: -3px;
                margin-left: 5px;
            }

            .nav.list-group li a .badge {
                position: absolute;
                right: 8px;
                top: 12px;
            }

        </style>

  </ps-tabs>

</script>

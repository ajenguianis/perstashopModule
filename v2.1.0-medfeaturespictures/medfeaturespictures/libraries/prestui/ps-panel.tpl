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
    <ps-panel-footer>
        <div class="panel-footer">
            <yield/>
        </div>

        <style scoped>

            .btn.pull-right {
                margin-left: 5px;
            }
            .btn.pull-left {
                margin-right: 5px;
            }

            a.btn i {
                display: block;
                width: 30px;
                height: 30px;
                margin: 0 auto;
                font-size: 28px;
                background: transparent;
                background-size: 26px;
                background-position: center
            }

        </style>
    </ps-panel-footer>
</script>

<script type="riot/tag">
    <ps-panel-footer-submit>

            <button type="submit" class="btn btn-default pull-{ opts.direction }" name="{ opts.name }">
                <i class="{ opts.icon }"></i> { opts.title }
            </button>

    </ps-panel-footer-submit>
</script>

<script type="riot/tag">
    <ps-panel-footer-link>

            <a class="btn btn-default pull-{ opts.direction }" href="{ opts.href }" target="{ opts.newTab == 'true' ? '_blank' : '' }">
                <i class="{ opts.icon }"></i> { opts.title }
            </a>

    </ps-panel-footer-link>
</script>

<script type="riot/tag">
    <ps-panel>

            <div class="panel">
                <div class="panel-heading" if={ opts.icon || opts.header }>
                        <i class="{ opts.icon }" if={ opts.icon }></i> { opts.header }
                </div>

                <yield/>

            </div>

    </ps-panel>
</script>

<script type="riot/tag">
    <ps-panel-divider>

            <hr/>

    </ps-panel-divider>
</script>

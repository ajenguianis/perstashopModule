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

	<ps-table>

		<form method="post" method="post" class="form-horizontal clearfix">

			<input type="hidden" name="token" value="">

			<div class="panel col-lg-12">

				<div class="panel-heading">
					<i class="{ opts.icon }" if={ opts.icon }></i> { opts.header }
					<span class="badge">{ this.rows.length }</span>
					<span class="panel-heading-action" if={ this.top_actions }>
						<a class="list-toolbar-btn" href="{ this.base_action_url }&action={ elem.action }" title="{ elem.title }" each={ elem, index in this.top_actions }>
							<span data-toggle="tooltip" class="label-tooltip" data-original-title="{ elem.title }" data-html="true" data-placement="top">
								<i class="process-icon-new"></i>
							</span>
						</a>
					</span>
				</div>

				<div class="table-responsive-row clearfix">
					<table class="table">

						<thead>
							<tr class="nodrag nodrop">
								<th each={ elem, index in this.columns } class="{ this.columns_classes[this.columns.indexOf(elem)] }">
									<span class="title_box">
										{ elem.content }
									</span>
								</th>
								<th class="fixed-width-md" if={ this.primary_action }></th>
							</tr>
						</thead>

						<tbody>

							<tr class="odd" each={ row, i in this.rows }>
								<td each={ value, key in this.columns_keys } class="{ this.columns_classes[key] }">
									<i class="icon-{ row[value] == 1 ? 'check' : 'remove' } status" if={ this.columns[key].bool }></i>
									<span if={ !this.columns[key].bool }>{ row[value] }</span>
								</td>
								<td if={ this.primary_action }>
									<div class="btn-group-action">
										<div class="btn-group pull-right">
											<a href="{ this.base_action_url }&action={ this.primary_action.action }&{ this.identifier }={ row[this.identifier] }" title="{ this.primary_action.title }" class="edit btn btn-default">
												<i class="icon-{ this.primary_action.icon }"></i> { this.primary_action.title }
											</a>
											<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" if={ this.secondary_actions.length }>
												<i class="icon-caret-down"></i>&nbsp;
											</button>
											<ul class="dropdown-menu" if={ this.secondary_actions.length }>
												<li each={ elem, index in this.secondary_actions }>
													<a href="{ this.base_action_url }&action={ elem.action }&{ this.identifier }={ row[this.identifier] }" title="{ elem.title }">
														<i class="icon-{ elem.icon }"></i> { elem.title }
													</a>
												</li>
											</ul>
										</div>
									</div>
								</td>
							</tr>

							<tr if={ this.empty_table }>
								<td class="list-empty" colspan="{ this.columns.length + 1 }">
									<div class="list-empty-msg">
										<i class="icon-warning-sign list-empty-icon"></i>
										{ this.opts.noItemsText }
									</div>
								</td>
							</tr>

						</tbody>

					</table>
				</div>

			</div>

		</form>

		<style scoped>

			i.status.icon-check {
				color: #72C279;
			}

			i.status.icon-remove {
				color: #E08F95;
			}

		</style>

		content = JSON.parse(this.root.getAttribute('content'))

		this.columns = content.columns
		this.rows = content.rows
		this.empty_table = this.rows.length == 0

		this.columns_classes = []
		this.columns_keys = []

		for (var i in this.columns) {
			this.columns_classes.push(this.columns[i].center == true ? 'center' : '')
			this.columns_keys.push(this.columns[i].key)
		}

		this.base_action_url = currentIndex + "&token={Tools::getAdminTokenLite(Context::getContext()->controller->controller_name)|escape:'htmlall':'UTF-8'}&" + jQuery.param(content.url_params)

		if (typeof content.rows_actions == 'object' && content.rows_actions.length > 0) {
			this.primary_action = content.rows_actions.slice(0, 1)[0]
			this.secondary_actions = content.rows_actions.slice(1)
		}
		else
			this.primary_action = null

		this.top_actions = content.top_actions

		this.identifier = content.identifier

	</ps-table>

</script>

? extends 'fluid'

? my $ref_width=80;
? my $ref_height=int($ref_width/4*3);

? block additional_headlines => sub {
<script src="/static/keyevent.js"></script>
<script src="/static/shapes.js"></script>
<script src="/static/needleeditor.js"></script>
<script type="text/javascript">
<!--
window.onload=function(){ 
  window.nEditor = new NeedleEditor('<?= ${@$needles[0]}{'image'} ?>');
};
-->
</script>
? }

? block locbar => sub {
<?= $self->include_file("../../htdocs/includes/moduleslistlocbar") ?>
? }

? block content => sub {
<div class="grid_3 alpha" id="sidebar">
	<div class="box box-shadow alpha" id="actions_box">
		<div class="box-header aligncenter">Actions</div>
		<div class="aligncenter">
			<?= $self->include_file("../../htdocs/includes/moduleslistoptions") ?>
			<a href="/cropimg/save/<?= $testname ?>/<?= $imgname ?>"><img src="/images/floppy.png" alt="crop" title="Crop Image" /></a>
			<a href="/cropimg/download/<?= $testname ?>/<?= $imgname ?>"><img src="/images/download.png" alt="crop" title="Crop Image" /></a>
		</div>
		<div class="aligncenter">
	        	<textarea id="needleeditor_textarea" name="json" readOnly="yes" style="width:94%; height:300px;"></textarea>
			<div id="needleeditor_tags" style="margin: 0 18px 0 0;"></div>
		</div>
	</div>

	<?= $self->include_file("../../htdocs/includes/moduleslist") ?>
</div>

<div class="grid_13 omega">
	<div class="box box-shadow">
		<?= $self->include_file("../../htdocs/includes/moduleslisttabs") ?>

		<table style="width: auto;">
			<tr>
				<th>Needle</th>
				<th>Image</th>
				<th>Areas</th>
				<th>Matches</th>
			</tr>
			
			<? for my $needle (@$needles) { ?>
				<tr>
					<td><?= $needle->{'name'} ?></td>
					<td><a href="#" onclick="window.nEditor.LoadBackground('<?= $needle->{'image'} ?>'); return false;">Use</a></td>
					<td><a href="#" onclick="window.nEditor.LoadAreas('<?= JSON::to_json($needle->{'area'}) ?>'); return false;">Use</a></td>
					<td><a href="#" onclick="window.nEditor.LoadAreas('<?= JSON::to_json($needle->{'matches'}) ?>'); return false;">Use</a></td>
				</tr>
			<? } ?>
		</table>
		<div style="margin: 0 10px; position: relative; width: 1024px; height: 768px;">
             		<canvas tabindex="1" id="needleeditor_canvas" width="1024" height="768" style="border: 1px solid black;">This text is displayed if your browser does not support HTML5 Canvas.</canvas>
		</div>
	</div>

	<? if(@$imglist) {
             my $img_count = 1; ?>
	<div class="box box-shadow">
		<div style="margin: 0 20px; overflow-x: scroll; overflow-y: hidden; overflow: auto; white-space: nowrap;">
			<? for my $refimg (@$imglist) { ?>
			<span class="refcomppic">
				<a href="<?= $img_count++ ?>"><img
					src="/<?= $prj ?>/testresults/<?= $testname ?>/<?= $refimg->{'screenshot'} ?>?size=<?= $ref_width ?>x<?= $ref_height ?>"
					width="<?= $ref_width ?>" height="<?= $ref_height ?>" alt="<?= $refimg->{'name'} ?>.png" title="<?= $refimg->{'name'} ?>.png"
					class="<?= "resborder\L$refimg->{'result'}" ?>" /></a>
			</span>
			<? } ?>
		</div>
	</div>
	<? } ?>
</div>
? } # endblock content

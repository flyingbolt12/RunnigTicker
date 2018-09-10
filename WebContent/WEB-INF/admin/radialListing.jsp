<!DOCTYPE html>
<meta charset="utf-8">
<style>

.node circle {
  fill: #fff;
  stroke: steelblue;
  stroke-width: 1.5px;
}

.node {
  font: 10px sans-serif;
}

.link {
  fill: none;
  stroke: #ccc;
  stroke-width: 1.5px;
}

</style>
<body>
<script src="http://d3js.org/d3.v3.min.js"></script>
<script>

$( document ).ready(function() {
var diameter = document.getElementById("customBody").offsetHeight;

var tree = d3.layout.tree()
    .size([360, diameter / 2 - 120])
    .separation(function(a, b) { return (a.parent == b.parent ? 1 : 2) / a.depth; });

var diagonal = d3.svg.diagonal.radial()
    .projection(function(d) { return [d.y, d.x / 180 * Math.PI]; });

var svg = d3.select("#loadhart").append("svg")
    .attr("width", diameter)
    .attr("height", diameter - 50)
  .append("g")
    .attr("transform", "translate(" + diameter / 2 + "," + diameter / 2 + ")");

d3.json("radialListing.do?parameter=radialListing", function(error, root) {
	
	$("#loading").html("");
	
  var nodes = tree.nodes(root),
      links = tree.links(nodes);

  var link = svg.selectAll(".link")
      .data(links)
    .enter().append("path")
      .attr("class", "link")
      .attr("d", diagonal);

  var node = svg.selectAll(".node")
      .data(nodes)
    .enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) { return "rotate(" + (d.x - 90) + ")translate(" + d.y + ")"; })

  node.append("circle")
      .attr("r", 10.5)
      .on("click", click)
      .style("cursor","pointer");

  node.append("text")
      .attr("dy", ".51em")
      .attr("text-anchor", function(d) { return d.x < 180 ? "start" : "end"; })
      .attr("transform", function(d) { return d.x < 180 ? "translate(8)" : "rotate(180)translate(-8)"; })
      .on("click", click)
      .style("cursor","pointer")
      .text(function(d) { return d.firstName; });
});

d3.select(self.frameElement).style("height", diameter - 50 + "px");


});

function click(d) 
{
    //alert(d.iduser); 
    document.forms[0].iduser.value= d.iduser;
    document.forms[0].submit();
}
</script>
<div align="center" id="loading">Awesome things are loading....</div>
<div align="center" id="loadhart"></div>
<form action="genericForwardAction.do?forwardTo=admin/adminFunctions.jsp" method="post">
<input type="hidden" name="showSeacrAccr" value="Y">
<input type="hidden" name="iduser" >
</form>
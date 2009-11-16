$(".level").change(function() {
	updateValue(this, "level", "character");
});

$(".experience").change(function() {
	updateValue(this, "experience", "character");
});

$(".brave").change(function() {
	updateValue(this, "brave", "character");
});

$(".faith").change(function() {
	updateValue(this, "faith", "character");
});

$(".job_level").change(function() {
	updateValue(this, "job_level", "character_job");
});

$(".completed").click(function() {
	id = $(this).attr("id");
	character_job_ability_id = /\d+/.exec(id);
	$.ajax({url: "/character_job_abilities/" + character_job_ability_id,
					type: "PUT",
					dataType: "json",
					success: function(response) {
						element = $("#cj_ability_" + response["id"]);
						matching = /X/.test(element.html());
						if(matching) {
							element.html("&nbsp;");
						} else {
							element.html("X");
						}
						updateJobCssClass(response["character_job_id"], response["mastery_class"]);
					}
		
	});
});

function updateValue(element, attribute, model) {
	name = $(element).attr("name");
	updated_value = $(element).val();
	model_id = /\d+/.exec(name);
	$.ajax({url: "/" + model + "/" + model_id, 
					type: "PUT",
					dataType: "json",
					data: model + "[" + attribute + "]=" + updated_value, 
					success: function(response) {
						if(response == "false") {
							alert("Job Level must be between 0 and 8");	
						} 
					}
	});
};

$("#tabs").tabs();

$(".dialog").dialog({autoOpen: false});

function updateJobCssClass(job_id, css_class) {
	parent_td = $("#character_job_" + job_id + "_job_level").parent()[0];
	$(parent_td).removeClass();
	$(parent_td).addClass(css_class);
};
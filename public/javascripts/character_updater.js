$(".job_level").change(function() {
	name = $(this).attr("name");
	job_level = $(this).val();
	character_job_id = /\d+/.exec(name);
	$.ajax({url: "/character_jobs/" + character_job_id, 
					type: "PUT", 
					data: "character_job[job_level]=" + job_level, 
					success: function(response) {
						if(response == "false") {
							alert("Job Level must be between 0 and 8");	
						}
					}
	});
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

function updateJobCssClass(job_id, css_class) {
	parent_td = $("#character_job_" + job_id + "_job_level").parent()[0];
	$(parent_td).removeClass();
	$(parent_td).addClass(css_class);
};
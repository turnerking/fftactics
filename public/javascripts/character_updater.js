$(".level").change(function() {
	updateValue(this, "level", "character", "characters");
});

$(".experience").change(function() {
	updateValue(this, "experience", "character", "characters");
});

$(".brave").change(function() {
	updateValue(this, "brave", "character", "characters");
});

$(".faith").change(function() {
	updateValue(this, "faith", "character", "characters");
});

$(".job_level").change(function() {
	updateValue(this, "job_level", "character_job", "character_jobs");
});

$(".completed").click(function() {
	id = $(this).attr("id");
	character_job_ability_id = /\d+/.exec(id);
	$.ajax({url: "/character_job_abilities/" + character_job_ability_id,
					type: "PUT",
					dataType: "json",
					success: function(response) {
						toggleX(response["id"]);
						updateJobCssClass(response["character_job_element"], response["mastery_class"]);
					}
		
	});
});

function updateValue(element, attribute, model, controller) {
	name = $(element).attr("name");
	updated_value = $(element).val();
	model_id = /\d+/.exec(name);
	$.ajax({url: "/" + controller + "/" + model_id, 
					type: "PUT",
					dataType: "json",
					data: model + "[" + attribute + "]=" + updated_value,
					success: function(response) { responseToUpdate(response, attribute); }
					/* Used anomynous function with function in it to add extra variables*/
	});
};

function responseToUpdate(response, attribute) {
	if(isInvalid(response)) {
		if(isUpdatingJobLevel(attribute)) {
			alert("Job Level must be between 0 and 8");
		} else {
			alert("Entry is not valid");
		}
	} else {
		if(isUpdatingJobLevel(attribute)) {
			updateCharacterJobs(response);
		}
	}
};

$("#tabs").tabs();

$(".dialog").dialog({autoOpen: false});

function isInvalid(response) {
	return response == "false";
}

function isUpdatingJobLevel(attribute) {
	return attribute == "job_level";
}

function updateCharacterJobs(new_html) {
	jQuery.each(new_html, function(key, value) {
		attachChangeEventToNewInput(key, value["input"])
		updateJobCssClass(key, value["class"]);
	});
}

function toggleX(id) {
	element = $("#cj_ability_" + id);
	matching = /X/.test(element.html());
	if(matching) {
		element.html("&nbsp;");
	} else {
		element.html("X");
	}
}

function attachChangeEventToNewInput(element, input_html) {
	$(element).html(input_html);
	$(element + "_job_level").change(function() {
		updateValue(this, "job_level", "character_job", "character_jobs");
	});
}

function updateJobCssClass(element, css_class) {
	$(element).removeClass();
	$(element).addClass("col");
	$(element).addClass(css_class);
};
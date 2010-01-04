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
	updateValue(this, "completed", "character_job_ability", "character_job_abilities");
});

function updateValue(element, attribute, model, controller) {
	id = $(element).attr("id");
	updated_value = $(element).val();
	model_id = /\d+/.exec(id);
	$.ajax({url: "/" + controller + "/" + model_id, 
					type: "PUT",
					dataType: "json",
					data: model + "[" + attribute + "]=" + updated_value,
					success: function(response) { responseToUpdate(response, attribute); }
					/* Used anomynous function with function in it to add extra variables*/
	});
};

// function updateCharacterJobAbility(element) {
// 	id = $(element).attr("id");
// 	character_job_ability_id = /\d+/.exec(id);
// 	$.ajax({url: "/character_job_abilities/" + character_job_ability_id,
// 					type: "PUT",
// 					dataType: "json",
// 					success: function(response) { 
// 						toggleX(response["id"]);
// 						updateJobCssClass(response["character_job_element"], response["mastery_class"]);
// 					}
// 		
// 	});
// }

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
		} else if(isUpdatingCharacterJobAbility(attribute)) {
			toggleX(response["id"]);
			updateJobCssClass(response["character_job_element"], response["mastery_class"]);
		} else {
			//Do Nothing
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

function isUpdatingCharacterJobAbility(attribute) {
	return attribute == "completed";
}

function updateCharacterJobs(new_html) {
	jQuery.each(new_html, function(key, value) {
		createNewInput(key, value["input"]);
		attachChangeEventToNewInput(key)
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

function createNewInput(element, input_html) {
	$(element).html(input_html);
}

function attachChangeEventToNewInput(element) {
	$(element + "_job_level").change(function() {
		updateValue(this, "job_level", "character_job", "character_jobs");
	});
}

function updateJobCssClass(element, css_class) {
	$(element).removeClass();
	$(element).addClass("col");
	$(element).addClass(css_class);
};
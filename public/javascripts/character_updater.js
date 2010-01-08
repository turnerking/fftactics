var characterUpdater = {};

characterUpdater.updateValue = function(element, attribute, model, controller) {
	name = $(element).attr("name");
	updated_value = $(element).val();
	model_id = /\d+/.exec(name);
	$.ajax({url: "/" + controller + "/" + model_id, 
					type: "PUT",
					dataType: "json",
					data: model + "[" + attribute + "]=" + updated_value,
					success: function(response) { characterUpdater.responseToUpdate(response, attribute); }
					/* Used anomynous function with function in it to add extra variables*/
	});
};

characterUpdater.responseToUpdate = function(response, attribute) {
	if(isValidResponse(response)) {
		if(isUpdatingJobLevel(attribute)) {
			characterUpdater.updateCharacterJobs(response);
		} else if(isUpdatingCharacterJobAbility(attribute)) {
			characterUpdater.toggleX(response["id"]);
			characterUpdater.updateJobCssClass(response["character_job_element"], response["mastery_class"]);
		} else {
			//Do Nothing
		}
	}
};

characterUpdater.updateCharacterJobs = function(new_html) {
	jQuery.each(new_html, function(key, value) {
		characterUpdater.createNewInput(key, value["input"]);
		characterUpdater.attachChangeEventToNewInput(key)
		characterUpdater.updateJobCssClass(key, value["class"]);
	});
}

characterUpdater.toggleX = function(id) {
	element = $("#cj_ability_" + id);
	matching = /X/.test(element.html());
	if(matching) {
		element.html("&nbsp;");
	} else {
		element.html("X");
	}
}

characterUpdater.createNewInput = function(element, input_html) {
	$(element).html(input_html);
}

characterUpdater.attachChangeEventToNewInput = function(element) {
	$(element + "_job_level").change(function() {
		updateValue(this, "job_level", "character_job", "character_jobs");
	});
}

characterUpdater.updateJobCssClass = function(element, css_class) {
	$(element).removeClass();
	$(element).addClass("col");
	$(element).addClass(css_class);
};

function isValidResponse(response) {
	return response != "false";
}

function isUpdatingJobLevel(attribute) {
	return attribute == "job_level";
}

function isUpdatingCharacterJobAbility(attribute) {
	return attribute == "completed";
}

$(".level").change(function() {
	characterUpdater.updateValue(this, "level", "character", "characters");
});

$(".experience").change(function() {
	characterUpdater.updateValue(this, "experience", "character", "characters");
});

$(".brave").change(function() {
	characterUpdater.updateValue(this, "brave", "character", "characters");
});

$(".faith").change(function() {
	characterUpdater.updateValue(this, "faith", "character", "characters");
});

$(".job_level").change(function() {
	characterUpdater.updateValue(this, "job_level", "character_job", "character_jobs");
});

$(".completed").click(function() {
	characterUpdater.updateValue(this, "completed", "character_job_ability", "character_job_abilities");
});

$("#tabs").tabs();

$(".dialog").dialog({autoOpen: false});

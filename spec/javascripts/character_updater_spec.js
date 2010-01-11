require("spec_helper.js");
require("../../public/javascripts/jquery-ui-1.7.2.custom.min.js");
require("../../public/javascripts/character_updater.js");

Screw.Unit(function(){
  describe("CharacterUpdater", function(){
		describe("updateValue", function(){
			//TODO: figure out how to stub AJAX calls
			// it("calls responseToUpdate after AJAX call", function(){
			// 	var mock_object = mock(characterUpdater);
			// 	mock_object.should_receive("responseToUpdate").with_arguments("response", "coolness_factor").exactly(1, "times");
			//   characterUpdater.updateValue("#job_level_8", "job_level", "character_job", "character_jobs");			  
			// });
		});
		
		describe("responseToUpdate", function(){
		  it("calls updateCharacterJobs when updating job level", function(){
				var mock_object = mock(characterUpdater);
				mock_object.should_receive("updateCharacterJobs").with_arguments("response").exactly(1, "times")			
				characterUpdater.responseToUpdate("response", "job_level");
		  });
		
			it("calls toggleX and updateJobCssClass when updating job ability", function(){
			  var mock_object = mock(characterUpdater);
				mock_object.should_receive("toggleX").with_arguments("7").exactly(1, "times")			
				mock_object.should_receive("updateJobCssClass").with_arguments("#elem", "mastery20").exactly(1, "times")			
				characterUpdater.responseToUpdate({id: "7", character_job_element: "#elem", mastery_class: "mastery20"}, "completed");
			});
		});
		
		describe("updateCharacterJobs", function(){
		  it("calls createNewInput & attachChangeEventToNewInput & updateJobCssClass", function(){
				var element = "#character_job_8";
				var input = "<input id=\"character_job_8_job_level\" name=\"character_job[8][job_level]\" type=\"text\" />";
				var job_class = "mastery80";
		    var mock_object = mock(characterUpdater);
				mock_object.should_receive("createNewInput").with_arguments(element, input).exactly(1, "times");
				mock_object.should_receive("attachChangeEventToNewInput").with_arguments(element).exactly(1, "times");
				mock_object.should_receive("updateJobCssClass").with_arguments(element, job_class).exactly(1, "times");
				characterUpdater.updateCharacterJobs({"#character_job_8": {"input": input, "class": job_class}});
		  });
		});
		
		describe("toggleX", function(){
		  it("changes the content of div from X to blank space", function(){
		    characterUpdater.toggleX(2);
				expect($('#cj_ability_2').html()).to(match, new RegExp("&nbsp;"));
		  });
		
			it("changes the content of div from blank space to X", function(){
			  characterUpdater.toggleX(3);
				expect($('#cj_ability_3').html()).to(match, new RegExp("X"));
			});
		});
		
		describe("createNewInput", function(){
		  it("inserts the passed html into the passed element", function(){
		    characterUpdater.createNewInput("#new_input", "<input type=\"text\">")
				expect($("#new_input").html()).to(equal, "<input type=\"text\">")
		  });
		});
		
		describe("attachChangeEventToNewInput", function(){
		  
		});
		
		describe("updateJobCssClass", function(){
		  it("changes the mastery class of the element", function(){
		    characterUpdater.updateJobCssClass('#character_job_13', 'mastery50');
				expect($('#character_job_13').attr("class")).to(match, "mastery50");
				expect($('#character_job_13').attr("class")).to(match, "col");
		  });
		});	
		
		describe("isValidResponse", function(){
		  it("returns false if response is false", function(){
		    expect(isValidResponse("false")).to(equal, false)
		  });
		
			it("returns true if response is something else", function(){
			  expect(isValidResponse("something else")).to(equal, true)
			});
		});
		
		describe("isUpdatingJobLevel", function(){
		  it("returns true if attribute is job_level", function(){
		    expect(isUpdatingJobLevel("job_level")).to(equal, true);
		  });
		
			it("returns false if attribute is something else", function(){
			  expect(isUpdatingJobLevel("something_else")).to(equal, false);
			});
		});
		
		describe("isUpdatingCharacterJobAbility", function(){
		  it("returns true if attribute is completed", function(){
		    expect(isUpdatingCharacterJobAbility("completed")).to(equal, true);
		  });
		
			it("returns false if attribute is something else", function(){
			  expect(isUpdatingCharacterJobAbility("something_else")).to(equal, false);
			});
		});
		
		describe("events", function(){
		  
		});

  });
});

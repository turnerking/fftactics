require("spec_helper.js");
require("../../public/javascripts/jquery-ui-1.7.2.custom.min.js");
require("../../public/javascripts/character_updater.js");

Screw.Unit(function(){
  describe("CharacterUpdater", function(){
		describe("updateValue", function(){
		  
		});
		
		describe("updateCharacterJobAbility", function(){
		  
		});
		
		describe("responseToUpdate", function(){
		  it("calls updateCharacterJobs when updating job level", function(){
				var mock_object = mock(characterUpdater);
				mock_object.should_receive("updateCharacterJobs").with_arguments("response").exactly(1, "times")			
				characterUpdater.responseToUpdate("response", "job_level");
		  });
		});
		
		describe("isInvalid", function(){
		  it("returns true if response is false", function(){
		    expect(characterUpdater.isInvalid("false")).to(equal, true)
		  });
		
			it("returns false if response is something else", function(){
			  expect(characterUpdater.isInvalid("something else")).to(equal, false)
			});
		});
		
		describe("isUpdatingJobLevel", function(){
		  it("returns true if attribute is job_level", function(){
		    expect(characterUpdater.isUpdatingJobLevel("job_level")).to(equal, true);
		  });
		
			it("returns false if attribute is something else", function(){
			  expect(characterUpdater.isUpdatingJobLevel("something_else")).to(equal, false);
			});
		});
		
		describe("updateCharacterJobs", function(){
		  
		});
		
		describe("toggleX", function(){
		  
		});
		
		describe("insertNewInput", function(){
		  
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
		
		describe("events", function(){
		  
		});

  });
});

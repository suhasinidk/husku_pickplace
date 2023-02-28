
"use strict";

let Relation = require('./Relation.js');
let Property = require('./Property.js');
let Statement = require('./Statement.js');
let WmMonitor = require('./WmMonitor.js');
let Condition = require('./Condition.js');
let Param = require('./Param.js');
let WmElement = require('./WmElement.js');
let SkillProgress = require('./SkillProgress.js');
let ResourceDescription = require('./ResourceDescription.js');
let AssignTaskFeedback = require('./AssignTaskFeedback.js');
let AssignTaskAction = require('./AssignTaskAction.js');
let AssignTaskResult = require('./AssignTaskResult.js');
let AssignTaskActionFeedback = require('./AssignTaskActionFeedback.js');
let AssignTaskActionResult = require('./AssignTaskActionResult.js');
let AssignTaskActionGoal = require('./AssignTaskActionGoal.js');
let AssignTaskGoal = require('./AssignTaskGoal.js');

module.exports = {
  Relation: Relation,
  Property: Property,
  Statement: Statement,
  WmMonitor: WmMonitor,
  Condition: Condition,
  Param: Param,
  WmElement: WmElement,
  SkillProgress: SkillProgress,
  ResourceDescription: ResourceDescription,
  AssignTaskFeedback: AssignTaskFeedback,
  AssignTaskAction: AssignTaskAction,
  AssignTaskResult: AssignTaskResult,
  AssignTaskActionFeedback: AssignTaskActionFeedback,
  AssignTaskActionResult: AssignTaskActionResult,
  AssignTaskActionGoal: AssignTaskActionGoal,
  AssignTaskGoal: AssignTaskGoal,
};

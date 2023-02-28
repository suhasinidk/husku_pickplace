
"use strict";

let WmModify = require('./WmModify.js')
let ResourceGetDescriptions = require('./ResourceGetDescriptions.js')
let SkillCommand = require('./SkillCommand.js')
let WmQueryRelations = require('./WmQueryRelations.js')
let WoModify = require('./WoModify.js')
let WoQuery = require('./WoQuery.js')
let WmSetRelation = require('./WmSetRelation.js')
let WmGet = require('./WmGet.js')
let WoLoadAndSave = require('./WoLoadAndSave.js')

module.exports = {
  WmModify: WmModify,
  ResourceGetDescriptions: ResourceGetDescriptions,
  SkillCommand: SkillCommand,
  WmQueryRelations: WmQueryRelations,
  WoModify: WoModify,
  WoQuery: WoQuery,
  WmSetRelation: WmSetRelation,
  WmGet: WmGet,
  WoLoadAndSave: WoLoadAndSave,
};

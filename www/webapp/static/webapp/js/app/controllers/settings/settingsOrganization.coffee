###
  Custom controller for a `Vosae.Tenant` record.

  @class SettingsOrganizationController
  @extends Ember.ObjectController
  @namespace Vosae
  @module Vosae
###

Vosae.SettingsOrganizationController = Em.ObjectController.extend
  actions:
    save: (tenant)->
      tenant.get('transaction').commit()

    downloadTerms: (terms)->
      $.fileDownload(Vosae.Config.APP_ENDPOINT + terms.get('downloadLink'))
###
  A data model that represents a tenant

  @class Tenant
  @extends Vosae.Model
  @namespace Vosae
  @module Vosae
###

Vosae.Tenant = Vosae.Model.extend
  slug: DS.attr("string")
  name: DS.attr("string")
  email: DS.attr("string")
  phone: DS.attr("string")
  fax: DS.attr("string")
  registrationInfo: DS.belongsTo('Vosae.RegistrationInfo', {polymorphic: true})
  reportSettings: DS.belongsTo('Vosae.ReportSettings')
  postalAddress: DS.belongsTo("Vosae.Address")
  billingAddress: DS.belongsTo("Vosae.Address")
  svgLogo: DS.belongsTo("Vosae.File")
  imgLogo: DS.belongsTo("Vosae.File")
  terms: DS.belongsTo("Vosae.File")

  isUploadingImg: false
  isUploadingTerms: false

  logoUri: (->
    if @get('imgLogo.streamLink')
      return Vosae.Config.APP_ENDPOINT + @get('imgLogo.streamLink')
    else if @get('svgLogo.streamLink')
      return Vosae.Config.APP_ENDPOINT + @get('svgLogo.streamLink')
    return null
  ).property('svgLogo.streamLink', 'svgLogo.isLoaded', 'imgLogo.streamLink', 'imgLogo.isLoaded')

  checkValidity: ->
    errors = []

    # Name
    if not @get('name')
      errors.addObject('name is mandatory.')

    # PostalAddress
    if @get('postalAddress')
      if Ember.isNone @get('postalAddress.streetAddress')
        string = 'postalAddress.streetAddress is mandatory.'
        errors.addObject(string)

    # BillingAddress
    if @get('billingAddress')
      if Ember.isNone @get('billingAddress.streetAddress')
        string = 'billingAddress.streetAddress is mandatory.'
        errors.addObject(string)

    # RegisterInfo
    if not @get('registrationInfo')
        string = 'registrationInfo is mandatory.'
        errors.addObject(string)

    # ReportSettings
    if not @get('reportSettings')
        string = 'reportSettings is mandatory.'
        errors.addObject(string)

    unless Ember.isEmpty(errors)
      if @get('id')
        console.log 'API -> PUT  [Vosae.Tenant]'
      errors.forEach (line) ->
        console.log '  ' + line

    return true if Ember.isEmpty(errors)

  didUpdate: ->
    message = gettext("The settings of your organization have been successfully updated")
    Vosae.SuccessPopupComponent.open
      message: message


Vosae.Adapter.map "Vosae.Tenant",
  registrationInfo:
    embedded: "always"
  reportSettings:
    embedded: "always"
  postalAddress:
    embedded: "always"
  billingAddress:
    embedded: "always"
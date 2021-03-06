###
  A base model that represents a notification

  @class Notification
  @extends Vosae.Model
  @namespace Vosae
  @module Vosae
###

Vosae.Notification = Vosae.Model.extend
  read: DS.attr('boolean')
  sentAt: DS.attr('datetime')

  displayView: Em.View.extend
    templateName: 'notificationEntry/base'

  markAsRead: ->
    @set('read', true)

    # Get record and manually update his current state
    record = @
    record.set 'currentState', DS.RootState.loaded.updated.inFlight
    
    # Get store and adapter instances
    store = @get('store')
    adapter = store.get('adapter')
    
    # Generate url used to mark notification as read
    url = adapter.buildURL('notification', @get('id'))
    url = url + 'mark_as_read/'

    # Then send request to API
    adapter.ajax url, "PUT",
      success: (json) ->
        Ember.run @, ->
          @didSaveRecord store, Vosae.Notification, record, json 


###
  A data model that represents a notification of type contact saved

  @class ContactSavedNE
  @extends Vosae.Notification
  @uses Vosae.LazyContactResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.ContactSavedNE = Vosae.Notification.extend Vosae.LazyContactResourceMixin,
  contactName: DS.attr('string')
  contact: DS.belongsTo('Vosae.Contact')

  displayView: Em.View.extend
    templateName: 'notificationEntry/contactSaved'

  module: (->
    "contact"
  ).property()


###
  A data model that represents a notification of type organization saved

  @class OrganizationSavedNE
  @extends Vosae.Notification
  @uses Vosae.LazyOrganizationResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.OrganizationSavedNE = Vosae.Notification.extend Vosae.LazyOrganizationResourceMixin,
  organizationName: DS.attr('string')
  organization: DS.belongsTo('Vosae.Organization')

  displayView: Em.View.extend
    templateName: 'notificationEntry/organizationSaved'

  module: (->
    "contact"
  ).property()


###
  A data model that represents a notification of type quotation saved

  @class QuotationSavedNE
  @extends Vosae.Notification
  @uses Vosae.LazyQuotationResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.QuotationSavedNE = Vosae.Notification.extend Vosae.LazyQuotationResourceMixin,
  customerDisplay: DS.attr('string')
  quotationReference: DS.attr('string')
  quotation: DS.belongsTo('Vosae.Quotation')

  displayView: Em.View.extend
    templateName: 'notificationEntry/quotationSaved'

  module: (->
    "invoicing"
  ).property()


###
  A data model that represents a notification of type invoice saved

  @class InvoiceSavedNE
  @extends Vosae.Notification
  @uses Vosae.LazyInvoiceResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.InvoiceSavedNE = Vosae.Notification.extend Vosae.LazyInvoiceResourceMixin,
  customerDisplay: DS.attr('string')
  invoiceReference: DS.attr('string')
  invoice: DS.belongsTo('Vosae.Invoice')
  invoiceHasTemporaryReference: DS.attr('boolean')

  displayView: Em.View.extend
    templateName: 'notificationEntry/invoiceSaved'

  module: (->
    "invoicing"
  ).property()


###
  A data model that represents a notification of type downpayment invoice saved

  @class DownPaymentInvoiceSavedNE
  @extends Vosae.Notification
  @uses Vosae.LazyDownPaymentInvoiceResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.DownPaymentInvoiceSavedNE = Vosae.Notification.extend Vosae.LazyDownPaymentInvoiceResourceMixin,
  customerDisplay: DS.attr('string')
  downPaymentInvoiceReference: DS.attr('string')
  downPaymentInvoice: DS.belongsTo('Vosae.DownPaymentInvoice')

  displayView: Em.View.extend
    templateName: 'notificationEntry/downPaymentInvoiceSaved'

  module: (->
    "invoicing"
  ).property()


###
  A data model that represents a notification of type credit note saved

  @class CreditNoteSavedNE
  @extends Vosae.Notification
  @uses Vosae.LazyCreditNoteResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.CreditNoteSavedNE = Vosae.Notification.extend Vosae.LazyCreditNoteResourceMixin,
  customerDisplay: DS.attr('string')
  creditNoteReference: DS.attr('string')
  creditNote: DS.belongsTo('Vosae.CreditNote')

  displayView: Em.View.extend
    templateName: 'notificationEntry/creditNoteSaved'

  module: (->
    "invoicing"
  ).property()


###
  A data model that represents a notification of type event reminder

  @class EventReminderNE
  @extends Vosae.Notification
  @uses Vosae.LazyEventReminderResourceMixin
  @namespace Vosae
  @module Vosae
###

Vosae.EventReminderNE = Vosae.Notification.extend Vosae.LazyEventReminderResourceMixin,
  occursAt: DS.attr('datetime')
  summary: DS.attr('string')
  vosaeEvent: DS.belongsTo('Vosae.VosaeEvent')

  displayView: Em.View.extend
    templateName: 'notificationEntry/eventReminder'

  module: (->
    "organizer"
  ).property()

  inFuture: (->
    if @get('occursAt') > new Date()
      return true
    return false
  ).property('occursAt')
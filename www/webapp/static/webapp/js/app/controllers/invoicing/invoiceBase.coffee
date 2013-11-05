Vosae.InvoiceBaseController = Em.ObjectController.extend
  attachmentUploads: []

  addLineItem: ->
    @get("currentRevision.lineItems").createRecord()

  deleteLineItem: (lineItem) ->
    @preventStateError()
    Vosae.ConfirmPopupComponent.open
      message: gettext 'Do you really want to delete this line?'
      callback: (opts, event) =>
        if opts.primary
          @get('currentRevision.lineItems').removeObject lineItem

  deleteAttachment: (attachment) ->
    Vosae.ConfirmPopupComponent.open
      message: gettext 'Do you really want to delete this attachment?'
      callback: (opts, event) =>
        if opts.primary
          @get('attachments').removeObject attachment
          # Why the hell do we have to do this ?
          @get('content.stateManager').goToState('rootState.loaded.updated')
          # @get('content').set 'currentState', DS.RootState.loaded.updated 

  markAsState: (state) ->
    @get('content').markAsState state

  downloadPdf: (language) ->
    @get('content').downloadPdf language

  preventStateError: ->
    invoiceBase = @get 'content'
    invoiceBase.get 'currentRevision.senderAddress'
    invoiceBase.get 'currentRevision.billingAddress'
    invoiceBase.get 'currentRevision.deliveryAddress'
    invoiceBase.get 'currentRevision.currency'
    invoiceBase.get('currentRevision.currency.rates').getEach 'rate'

  cancel: (invoiceBase) ->
    switch invoiceBase.constructor
      when Vosae.Quotation
        if invoiceBase.get('id')
          return @transitionToRoute 'quotation.show', invoiceBase
        else
          return @transitionToRoute 'quotations.show'
      when Vosae.Invoice
        if invoiceBase.get('id')
          return @transitionToRoute 'invoice.show', invoiceBase
        else
          return @transitionToRoute 'invoices.show'
    return

  save: (invoiceBase) ->
    # Trigger errors
    errors = invoiceBase.getErrors()

    if errors.length
      alert(errors.join('\n'))
    else
      # Remove empty records
      senderAddress = invoiceBase.get('currentRevision.senderAddress')
      if senderAddress and senderAddress.isEmpty()
        invoiceBase.get('currentRevision').set 'senderAddress', null

      billingAddress = invoiceBase.get('currentRevision.billingAddress')
      if billingAddress and billingAddress.isEmpty()
        invoiceBase.get('currentRevision').set 'billingAddress', null

      deliveryAddress = invoiceBase.get('currentRevision.deliveryAddress')
      if deliveryAddress and deliveryAddress.isEmpty()
        invoiceBase.get('currentRevision').set 'deliveryAddress', null

      if invoiceBase.get('currentRevision.lineItems')
        invoiceBase.get('currentRevision.lineItems').forEach (item) ->
          if item.isEmpty()
            invoiceBase.get('currentRevision.lineItems').removeObject item

      event = if invoiceBase.get('id') then 'didUpdate' else 'didCreate'
      invoiceBase.one event, @, ->
        Ember.run.next @, ->
          switch invoiceBase.constructor
            when Vosae.Quotation
              @transitionToRoute 'quotation.show', @get('session.tenant'), invoiceBase
            when Vosae.Invoice
              @transitionToRoute 'invoice.show', @get('session.tenant'), invoiceBase
      invoiceBase.get('transaction').commit()

  delete: (invoiceBase) ->
    message = switch invoiceBase.constructor
      when Vosae.Quotation
        gettext("Do you really want to delete this quotation?")
      when Vosae.Invoice
        gettext("Do you really want to delete this invoice?")
    
    Vosae.ConfirmPopupComponent.open
      message: message
      callback: (opts, event) =>
        if opts.primary
          invoiceBase.one 'didDelete', @, ->
            Ember.run.next @, ->
              switch invoiceBase.constructor
                when Vosae.Quotation
                  @transitionToRoute 'quotations.show', @get('session.tenant')
                when Vosae.Invoice
                  @transitionToRoute 'invoices.show', @get('session.tenant')
          invoiceBase.deleteRecord()
          invoiceBase.get('transaction').commit()
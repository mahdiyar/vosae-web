# Generic view for infinite scrolling pages
Vosae.PaginatedView = Em.View.extend Vosae.InfiniteScrollMixin

# Generic view for all settings pages
Vosae.PageSettingsView = Em.View.extend Vosae.FullScreenContainerMixin, 
  outletContainerID: "ct-settings"

# Generic view for all tenant pages
Vosae.PageTenantView = Em.View.extend Vosae.FullScreenContainerMixin,  
  outletContainerID: "ct-tenant"

# Import views
require 'views/view'

require 'views/partials/controls/switch'
require 'views/partials/controls/datePicker'
require 'views/partials/controls/timePicker'
require 'views/partials/controls/colorPicker'
require 'views/partials/controls/simpleColorPicker'
require 'views/partials/controls/textAreaAutoGrow'
require 'views/partials/controls/textFieldAutoGrow'
require 'views/partials/controls/textFieldAutoNumeric'
require 'views/partials/controls/select'
require 'views/partials/controls/timezonesSelect'
require 'views/partials/controls/resourceSearchSelect'
require 'views/partials/controls/contactSearchSelect'
require 'views/partials/controls/organizationSearchSelect'
require 'views/partials/controls/itemSearchSelect'
require 'views/partials/controls/taxSearchSelect'
require 'views/partials/controls/userSearchSelect'
require 'views/partials/permissionsManager'
require 'views/partials/specificPermissionsManager'

require 'views/core/application'
require 'views/core/search'
require 'views/core/panels'
require 'views/core/dashboardShow'

require 'views/tenants/tenantsShow'
require 'views/tenants/tenantsAdd'

require 'views/settings/settingsOrganization'
require 'views/settings/settingsApplication'
require 'views/settings/settingsShowUsers'
require 'views/settings/settingsShowGroups'
require 'views/settings/settingsShowTaxes'
require 'views/settings/settingsEditUser'
require 'views/settings/settingsEditGroup'
require 'views/settings/settingsEditTax'
require 'views/settings/settingsInvoicingGeneral'
require 'views/settings/settingsNumbering'
require 'views/settings/settingsApiKeys'
require 'views/settings/settingsReport'

require 'views/contacts/organizationsShow'
require 'views/contacts/contactsShow'
require 'views/contacts/entityEdit'
require 'views/contacts/contactAdd'
require 'views/contacts/organizationAdd'
require 'views/contacts/organizationAddContact'
require 'views/contacts/contactShow'
require 'views/contacts/organizationShow'
require 'views/contacts/contactEdit'
require 'views/contacts/organizationEdit'

require 'views/invoicing/invoicingDashboard'
require 'views/invoicing/quotationsShow'
require 'views/invoicing/invoicesShow'
require 'views/invoicing/quotationShow'
require 'views/invoicing/invoiceShow'
require 'views/invoicing/invoiceBaseEdit'
require 'views/invoicing/quotationEdit'
require 'views/invoicing/invoiceEdit'
require 'views/invoicing/quotationsAdd'
require 'views/invoicing/invoicesAdd'
require 'views/invoicing/itemsShow'
require 'views/invoicing/itemsAdd'
require 'views/invoicing/itemShow'
require 'views/invoicing/itemEdit'
require 'views/invoicing/creditNoteShow'
require 'views/invoicing/purchaseOrderShow'
require 'views/invoicing/purchaseOrdersShow'
require 'views/invoicing/purchaseOrderEdit'
require 'views/invoicing/purchaseOrdersAdd'

require 'views/organizer/calendarListShow'
require 'views/organizer/calendarListEdit'
require 'views/organizer/vosaeEventShow'
require 'views/organizer/vosaeEventEdit'
require 'views/organizer/calendarListsShow'
require 'views/organizer/calendarListsAdd'

require 'views/bootstrap/alert'
require 'views/bootstrap/button'

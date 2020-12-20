class Role < ApplicationRecord
  has_many :users

  MANAGER_PERMISSION = [{ type: 'POST', url: /api+\/v1+\/shops+\/+\d+\/bulk_import/},
                        { type: 'GET', url: /api+\/v1+\/shops+\/+\d+\/products/},
                        { type: 'POST', url: /api+\/v1+\/shops+\/+\d+\/purchase/},
                        { type: 'GET', url: /api+\/v1+\/shops+\/+\d+\/purchased/}]
  ASSISTANT_PERMISSION = [{ type: 'GET', url: /api+\/v1+\/shops+\/+\d+\/products/},
                          { type: 'GET', url: /api+\/v1+\/shops+\/+\d+\/purchased/},
                          { type: 'POST', url: /api+\/v1+\/shops+\/+\d+\/purchase/},]
  PERMISSION = { '1' => MANAGER_PERMISSION, '2' => ASSISTANT_PERMISSION }
  PERMISSIONS_REQUIRED = [/api+\/v1+\/shops+\/+\d+\/bulk_import/]


end

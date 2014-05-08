class authorized_keys::validate {
  if !empty($authorized_keys::rolesusers) and !empty($authorized_keys::rolesauth) and !empty($authorized_keys::authorized_keys) {
    $rolesusers = $authorized_keys::rolesusers
    $rolesauth = $authorized_keys::rolesauth
    $rolearray = unique(split(inline_template('<% @rolesusers.each do |user,userhash| -%><% userhash["roles"].each do |role| -%><%= "%s," % role %><% end -%><% end -%>'),','))
    $keyarray = unique(flatten(values($rolesauth)))
    authorized_keys::validateroles { $rolearray: } 
    authorized_keys::validatekeys { $keyarray: }
  }
  elsif empty($authorized_keys::rolesusers) {
    notice ('Roles/users hiera structures is empty')
  }
  else {
    if empty($authorized_keys::rolesauth) {
    notice ('Roles/auth hiera structures is empty')
    }
  }
}

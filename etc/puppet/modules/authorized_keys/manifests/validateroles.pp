define authorized_keys::validateroles {
  authorized_keys::parsevalidate_array { $title:
    arrayvar => keys($authorized_keys::rolesauth),
    key      => $title;
  }
}

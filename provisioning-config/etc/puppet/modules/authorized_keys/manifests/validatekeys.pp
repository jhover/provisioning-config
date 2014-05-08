define authorized_keys::validatekeys {
  authorized_keys::parsevalidate_array { $title:
    arrayvar => keys($authorized_keys::authorized_keys),
    key      => $title;
  }
}

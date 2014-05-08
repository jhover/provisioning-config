define authorized_keys::parsevalidate_array($arrayvar,$key) {
  $arrayvarstr = join($arrayvar,',')
  if !member($arrayvar,$key) {
    fail ("${key} does not exist in hiera ierarchy, the existing items are: ${arrayvarstr}")
  }
}

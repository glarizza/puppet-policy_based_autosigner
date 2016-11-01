class policy_based_autosigner::params {
  $autosign_script_path             = "${settings::confdir}/autosign.rb"
  $autosign_script_owner            = 'pe-puppet'
  $autosign_script_group            = 'pe-puppet'
  $csr_attributes_file_owner        = 'pe-puppet'
  $csr_attributes_file_group        = 'pe-puppet'
  $csr_attributes_file_path         = "${settings::confdir}/csr_attributes.yaml"
  $server_side_valid_password       = 'MyUncleLukeApproves'
  $is_master                        = false
  $create_csr_attributes_file       = true
  $csr_attributes_file_content_hash = {
    'custom_attributes'   => {
      'challengePassword' => $server_side_valid_password,
    }
  }
}

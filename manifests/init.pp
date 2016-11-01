class policy_based_autosigner_example (
  String  $autosign_script_path             = $policy_based_autosigner::params::autosign_script_path,
  String  $autosign_script_owner            = $policy_based_autosigner::params::autosign_script_owner,
  String  $autosign_script_group            = $policy_based_autosigner::params::autosign_script_group, 
  String  $server_side_valid_password       = $policy_based_autosigner::params::server_side_valid_password, 
  String  $csr_attributes_file_owner        = $policy_based_autosigner::params::csr_attributes_file_owner, 
  String  $csr_attributes_file_group        = $policy_based_autosigner::params::csr_attributes_file_group, 
  String  $csr_attributes_file_path         = $policy_based_autosigner::params::csr_attributes_file_path, 
  String  $csr_attributes_file_content_hash = $policy_based_autosigner::params::csr_attributes_file_content_hash,
  Boolean $is_master                        = false,
  Boolean $set_autosign_in_puppet_conf      = true,
  Boolean $create_csr_attributes_file       = true,
  Boolean $notify_pe_puppetserver           = true,
) {
  if $is_master {
    file { 'autosign_script':
      ensure  => file,
      path    => $autosign_script_path,
      owner   => $autosign_script_owner,
      group   => $autosign_script_group,
      mode    => '0755',
      content => template("${module_name}/autosign.rb.erb"),
    }

    if $set_autosign_in_puppet_conf {
      $notification = $notify_pe_puppetserver ? {
        true    => Service['pe-puppetserver'],
        default => undef,
      }

      ini_setting { "set_autosign_in_puppet_conf":
        ensure  => present,
        path    => "${settings::confdir}/puppet.conf",
        section => 'master',
        setting => 'autosign',
        value   => $autosign_script_path,
        notify  => $notification,
      }
    }
  }

  if $create_csr_attributes_file {
    hash_file { 'csr_attributes_file':
      ensure => file,
      path   => $csr_attributes_file_path,
      owner  => $csr_attributes_file_owner,
      group  => $csr_attributes_file_group,
      value  => $csr_attribues_file_content_hash,
      mode   => '0644',
    }
  }
  
}

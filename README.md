# Open Corporates Terraform Test.

## Requirements

- **Requires the dev-vpc to have been pre created.**
    * Private and public subnets with tags like Purpose="private".
    * Security groups for rds and lambda.
- **Requires the monitoring roles.**
   * cloudwatch permissions.
   * allow rds to assume this role.Requires the terraform roles with permissions.
   * all the permissions required for the role to create the rds and lambda.
- **Requires lambda roles.**
   * lambda assume permissions.
   * permissions to create the lambda and networking.
   * access secrets manager to read the passwords.



- **Notes**
    * Terraform is unable to create DB users by default and hence the way to do it is to invoke an external script or in this case a lambda to create these DB ro/rw users.
    * the RDS  master/read/write passwords are create using random.
    * the above passwords are stored in secrets manager for the lamnda function to consume.


- **Improvements**
    * Current code is a bit static in the sense that a lambda will need to be created everytime a rds is spun up. The proper direction would be to have a single lambda that can be invoked anytime a rds is spun up.

- **Caveats.**
    * timing issues
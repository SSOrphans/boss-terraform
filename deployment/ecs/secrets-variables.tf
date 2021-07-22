variable "sm_info" {
  type = object({
    name            = string
    recovery_window = number
  })
  description = "Provide secret manager's name and recovery window number in days"
}
variable "internal_interface" {
  description = "Internal interface used for communication within the cluster"
  type        = string
}

variable "template_id" {

}

# variable "control_plane" {
#   description = "Control plane hosts configuration"
#   type = list(object({
#     hostname = string
#     ip       = string
#   }))
# }

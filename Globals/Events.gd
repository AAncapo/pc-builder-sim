extends Node

signal new_package(pckg)
signal interaction_started(obj)
signal interaction_ended

signal new_client_request(req)
signal request_accepted(post)
signal request_completed(request)

signal component_installed(cdata)
signal component_uninstalled(cdata)
signal no_slot_available(cdata)
signal component_already_installed(cdata)

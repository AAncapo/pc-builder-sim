extends Node

signal interact(tag)
signal init_interaction(obj)
signal stop_interaction

signal new_package(pckg)

signal new_client_request(req)
signal request_accepted(post)
signal request_completed(request)

signal component_installed(cdata)
signal component_uninstalled(cdata)
signal no_slot_available(cdata)
signal component_already_installed(cdata)

signal item_uploaded(data)
signal items_buyed()

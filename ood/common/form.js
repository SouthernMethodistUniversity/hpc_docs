'use strict'

/*
 * Function to handle partition limitations
 */
function partition_limits(selected_queue, enable_exclusive) {

	// console.log("running partition limits with queue: " + selected_queue + " \n\r");

        // set a max time for all queues
        var ood_max_time = 12;

	// Get Form Fields
	var time;
	var cpus;
	var mem;
	var gpu;
	var node;
	var gpu_label;
	if ($('#bc_num_hours').length > 0) {
		time = $('#bc_num_hours');
		// console.log("has time \n\r");
	}
	if ($('#num_cpus').length > 0) {
		cpus = $('#num_cpus');
		// console.log("has cpus \n\r");
	}
	if ($('#num_mem').length > 0) {
		mem = $('#num_mem');
		// console.log("has mem \n\r");
	}
	if ($('#num_gpus').length > 0) {
		gpu = $('#num_gpus');
		// console.log("has gpus \n\r");
	}
	if ($('#num_nodes').length > 0) {
		node = $('#num_nodes');
		// console.log("has nodes \n\r");
	}
	if (gpu) {
		gpu_label = document.querySelector("[for='num_gpus']").closest('div.form-group');
		// console.log("has gpu label \n\r");
	}

	// Get Default Max Values
	var max_time = 0;
	var max_cpu = 0;
	var max_mem = 0;
	var max_gpu = 0;
	var max_node = 0;

	var min_time = 1;
	var min_cpu = 1;
	var min_mem = 1;
	var min_gpu = 0;
	var min_node = 1;

	if (time) {
		max_time = time.attr("max");
	}
	if (cpus) {
		max_cpu = cpus.attr("max");
	}
	if (mem) {
		max_mem = mem.attr("max");
	}
	if (gpu) {
		max_gpu = gpu.attr("max");
	}
	if (node) {
		max_node = node.attr("max");
	}

	if (selected_queue === "development") {
		max_time = 2;
		max_cpu = 256;
		max_mem = 374;
		max_gpu = 8;
		max_node = 4;
	}
	else if (selected_queue === "standard-mem-s") {
		max_time = 24;
		max_cpu = 36;
		max_mem = 250;
		max_gpu = 0;
		max_node = 81;
	}
	else if (selected_queue === "standard-mem-m") {
		max_time = 168;
		max_cpu = 36;
		max_mem = 250;
		max_gpu = 0;
		max_node = 30;
	}
	else if (selected_queue === "standard-mem-l") {
		max_time = 720;
		max_cpu = 36;
		max_mem = 250;
		max_gpu = 0;
		max_node = 25;
	}
	else if (selected_queue === "medium-mem-1-s") {
		max_time = 24;
		max_cpu = 36;
		max_mem = 750;
		max_gpu = 0;
		max_node = 20;
	}
	else if (selected_queue === "medium-mem-1-m") {
		max_time = 168;
		max_cpu = 36;
		max_mem = 750;
		max_gpu = 0;
		max_node = 11;
	}
	else if (selected_queue === "medium-mem-1-l") {
		max_time = 720;
		max_cpu = 36;
		max_mem = 750;
		max_gpu = 0;
		max_node = 6;
	}
	else if (selected_queue === "medium-mem-2") {
		max_time = 336;
		max_cpu = 24;
		max_mem = 750;
		max_gpu = 0;
		max_node = 3;
	}
	else if (selected_queue === "high-mem-1") {
		max_time = 336;
		max_cpu = 36;
		max_mem = 1500;
		max_gpu = 0;
		max_node = 6;
	}
	else if (selected_queue === "high-mem-2") {
		max_time = 336;
		max_cpu = 40;
		max_mem = 1500;
		max_gpu = 0;
		max_node = 6;
	}
	else if (selected_queue === "mic") {
		max_time = 168;
		max_cpu = 256;
		max_mem = 374;
		max_gpu = 0;
		max_node = 39;
	}
	else if (selected_queue === "gpgpu-1") {
		max_time = 168;
		max_cpu = 36;
		max_mem = 250;
		max_gpu = 1;
		max_node = 36;
	}
	else if (selected_queue === "v100x8") {
		max_time = 168;
		max_cpu = 36;
		max_mem = 750;
		max_gpu = 8;
		max_node = 3;
	}
	else if (selected_queue === "htc") {
		max_time = 24;
		max_cpu = 1;
		max_mem = 250;
		max_gpu = 0;
		max_node = 1;
	}
	else if (selected_queue === "fp-gpgpu-2") {
		max_time = 20000;
		max_cpu = 24;
		max_mem = 120;
		max_gpu = 8;
		max_node = 1;
	}
	else if (selected_queue === "fp-gpgpu-3") {
		max_time = 20000;
		max_cpu = 40;
		max_mem = 375;
		max_gpu = 2;
		max_node = 2;
	}
	else if (selected_queue === "fp-gpgpu-4") {
		max_time = 20000;
		max_cpu = 36;
		max_mem = 375;
		max_gpu = 2;
		max_node = 1;
	}
	else if (selected_queue === "desktop") {
		max_time = 24;
		max_cpu = 36;
		max_mem = 250;
		max_gpu = 0;
		max_node = 1;
	}
	else if (selected_queue === "desktop-vdi") {
		max_time = 24;
		max_cpu = 36;
		max_mem = 250;
		max_gpu = 1;
		max_node = 1;
	}

	// if exlusive is enabled. Enforce min = max
	if (enable_exclusive) {
		min_cpu = max_cpu;
		min_gpu = max_gpu;
		min_mem = max_mem;
	}

        // enforce max time regardless of queue
        if (max_time > ood_max_time) {
                max_time = ood_max_time;
        }

	// Handle Max Time Changes
	if (time) {
		if (time.val() > max_time) {
			time.val(max_time)
		}
		time.attr({ "max": max_time });

		if (time.val() < min_time) {
			time.val(min_time)
		}
		time.attr({ "min": min_time });
	}

	// Handle Max CPU Changes
	if (cpus) {
		if (cpus.val() > max_cpu) {
			cpus.val(max_cpu)
		}
		cpus.attr({ "max": max_cpu });
		if (cpus.val() < min_cpu) {
			cpus.val(min_cpu)
		}
		cpus.attr({ "min": min_cpu });
	}

	// Handle Max Mem Changes
	if (mem) {
		if (mem.val() > max_mem) {
			mem.val(max_mem)
		}
		mem.attr({ "max": max_mem });
		if (mem.val() < min_mem) {
			mem.val(min_mem)
		}
		mem.attr({ "min": min_mem });
	}

	// Handle Max GPU Changes
	if (gpu) {
		if (gpu.val() > max_gpu) {
			gpu.val(max_gpu)
		}
		// console.log("gpu val" + gpu.val() + " \n\r");
		// console.log("gpu max" + max_gpu + " \n\r");
		gpu.attr({ "max": max_gpu });
		if (max_gpu === 0) {
			// console.log("disabling gpu\n\r");
			gpu.attr('disabled', 'disabled');
			gpu.hide();
			if (gpu_label) {
				gpu_label.style.display = "none";
			}
		}
		else {
			// console.log("enabling gpu \n\r");
			gpu.removeAttr('disabled');
			gpu.show();
			if (gpu_label) {
				gpu_label.style.display = "inline";
			}

		}
		if (gpu.val() < min_gpu) {
			gpu.val(min_gpu)
		}
		gpu.attr({ "min": min_gpu });
	}

	// handle max nodes
	if (node) {
		if (node.val() > max_node) {
			node.val(max_node)
		}
		node.attr({ "max": max_node })
		if (node.val() < min_node) {
			node.val(min_node)
		}
		node.attr({ "min": min_node })
	}

	// handle development queue 1 mic, 1 p100, 2 standard
	if (selected_queue === "development") {

		// if more than 1 node requested. Disable gpu + mic
		if (node) {
			if (node.val() > 1) {

				// don't allow requesting more than 36 cores
				// even though the mic has more
				if (cpus) {
					if (cpus.val() > 36) {
						cpus.val(36)
					}
					cpus.attr({ "max": 36 });
				}

				// disable gpu since there's only 1
				if (gpu) {
					gpu.attr({ "max": 0 });
					gpu.attr('disabled', 'disabled');
					gpu.hide();
					// console.log("disable gpu -- 2+ nodes \n\r");
					if (gpu_label) {
						gpu_label.style.display = "none";
					}
					if (gpu.val() > 0) {
						gpu.val(0);
					}
				}

				// set max memory to what is availabe
				if (mem) {
					if (mem.val() > 250) {
						mem.val(250);
					}
					mem.attr({ "max": 250 });
				}
			}
		}

		// check to see if a GPU was requested
		if (gpu) {
			if (gpu.val() > 0) {
				// only 1 gpu node
				if (node) {
					if (node.val() > 1) {
						node.val(1)
					}
					node.attr({ "max": 1 })
				}

				// can't use a MIC node with a GPU
				if (cpus) {
					if (cpus.val() > 36) {
						cpus.val(36)
					}
					cpus.attr({ "max": 36 });
				}

				// set max memory to what is availabe
				if (mem) {
					if (mem.val() > 250) {
						mem.val(250);
					}
					mem.attr({ "max": 250 });
				}
			}
		}

		// check if a MIC node was requested (based on core count or mem)
		if (cpus && mem) {
			if (cpus.val() > 36 || mem.val() > 250) {
				// only 1 mic node
				if (node) {
					if (node.val() > 1) {
						node.val(1)
					}
					node.attr({ "max": 1 })
				}

				// can't use a MIC node with a GPU
				if (gpu) {
					gpu.attr({ "max": 0 });
					gpu.attr('disabled', 'disabled');
					gpu.hide();
					// console.log("disable gpu -- mic \n\r");
					if (gpu_label) {
						gpu_label.style.display = "none";
					}
					if (gpu.val() > 0) {
						gpu.val(0);
					}
				}
			}
		}
	}
  
        // set max values for cores, mem, and gpus if exclusive is enabled
        // disable if dev because there "all resources" doesn't make sence
        if (enable_exclusive && (selected_queue !== "development") && (selected_queue !== "htp")) {
        	gpu.val(max_gpu);
		cpus.val(max_cpu);
		mem.val(max_mem);
        }
}

function disable_list_options(list) {

  Array.from(list.options).forEach(function (option_element) {
				option_element.disabled = true;});
}

function enable_list_options(list) {

  Array.from(list.options).forEach(function (option_element) {
				option_element.disabled = false;});
}

function disable_field(field, field_label) {
  field_label.style.display = "none";
  field.attr('disabled', 'disabled');
  field.hide();
}

function enable_field(field, field_label) {
  field.removeAttr('disabled');
  field.show();
  field_label.style.display = "inline";
}

function disable_time_controlls(time, time_label, start, start_label, end, end_label, enable_start, enable_start_label, enable_end, enable_end_label)
{
  disable_field(time, time_label);
  disable_field(start, start_label);
  disable_field(end, end_label);
  disable_field(enable_start, enable_start_label);
  disable_field(enable_end, enable_end_label);
}

function enable_time_controlls(time, time_label, start, start_label, end, end_label, enable_start, enable_start_label, enable_end, enable_end_label)
{
  enable_field(time, time_label);
  enable_field(enable_start, enable_start_label);
  enable_field(enable_end, enable_end_label);
  if (enable_start.is(":checked")) {
    enable_field(start, start_label);
  } else {
    disable_field(start, start_label);
  }
  if (enable_end.is(":checked")) {
    enable_field(end, end_label);
  } else {
    disable_field(end, end_label);
  }
}

function handle_reservation_change(queue, reservation) {

  // disable all queues
  disable_list_options(queue[0])

  // get the valid queues from the reservations selection
  var valid_queues = reservation[0].value.split(',');
  var selected_option = false
                
  Array.from(queue[0].options).forEach(function (option_element) {
    let option_value = option_element.value;
    for (var i = 1; i < valid_queues.length -1; i++) {
      if (!option_value.localeCompare(valid_queues[i])) {
        option_element.disabled = false;
        // select first valid queue
        if (!selected_option) {
          selected_option = true;
          queue[0].value = option_value;
        }
      }
    }
  });
}

/*
 * Invoke the functions when the DOM is ready.
 */
$(document).ready(function () {

	// Handle Partition Specific Settings
	let queue;
	let ngpus;
	let ncpus;
	let nnodes;
	let nmem;
        let time;
        let time_label;
        let enable_start;
        let enable_start_label;
	let start;
	let start_label;
	let enable_end;
        let enable_end_label;
	let end;
	let end_label;
        let exclusive;
	let exclusive_label;
        var enable_exclusive = false;
        let reservation;
        let enable_reservation_label;
        var enable_reservation = false;
        let reservation_label;

	if ($('#batch_connect_session_context_custom_queue').length > 0) {
		queue = $('#batch_connect_session_context_custom_queue');
		// Set Default Partition
		$('select').find('option[value=interactive]').attr('selected', 'selected');
	}
	if ($('#num_gpus').length > 0) {
		ngpus = $('#num_gpus');
	}
	if ($('#num_cpus').length > 0) {
		ncpus = $('#num_cpus');
	}
	if ($('#num_nodes').length > 0) {
		nnodes = $('#num_nodes');
	}
	if ($('#num_mem').length > 0) {
		nmem = $('#num_mem');
	}
	if ($('#enable_start').length > 0) {
		enable_start = $('#enable_start');
                enable_start_label = document.querySelector("[for='enable_start']").closest('div.form-group');
		//console.log("enable_start: " + enable_start.is(":checked")  + " \n\r");
	}
	if ($('#start').length > 0) {
		start = $('#start');
	}
	if ($('#enable_end').length > 0) {
		enable_end = $('#enable_end');
		enable_end_label = document.querySelector("[for='enable_end']").closest('div.form-group');
		//console.log("enable_enable: " + enable_end.is(":checked")  + " \n\r");
	}
	if ($('#end').length > 0) {
		end = $('#end');
	}
	if ($('#enable_exclusive').length > 0) {
		exclusive = $('#enable_exclusive');
		enable_exclusive = exclusive.is(":checked");
		exclusive_label = document.querySelector("[for='enable_exclusive']").closest('div.form-group');
	}

        if ($('#enable_reservation').length > 0) {
		enable_reservation = $('#enable_reservation');
                enable_reservation_label = document.querySelector("[for='enable_reservation']").closest('div.form-group');
	}
        if ($('#batch_connect_session_context_reservation_list').length > 0) {
                reservation = $('#batch_connect_session_context_reservation_list');
        }

        
        if ($('#bc_num_hours').length > 0) {
		time = $('#bc_num_hours');
                time_label = document.querySelector("[for='bc_num_hours']").closest('div.form-group');
	}
       

	// enable disable fields on page load
	if (start && enable_start) {
		start_label = document.querySelector("[for='start']").closest('div.form-group');
		if (start_label) {
			if (enable_start.is(":checked")) {
                                enable_field(start, start_label);
			} else {
				disable_field(start, start_label);
			}
		}
	}

	if (end && enable_end) {
		end_label = document.querySelector("[for='end']").closest('div.form-group');
		if (end_label) {
			if (enable_end.is(":checked")) {
				enable_field(end, end_label);
			} else {
				disable_field(end, end_label);
			}
		}
	}

        
        if (reservation && enable_reservation) {
                reservation_label = document.querySelector("[for='batch_connect_session_context_reservation_list']").closest('div.form-group');

                if (reservation_label) {
                        // check if there are valid reservations
                        var valid_res = true;
                        Array.from(reservation[0].options).forEach(function (option_element) {
			     let option_value = option_element.value;
			     if (option_value === "-1") {
				valid_res = false;
			     }
		        });

                        // disable check box for reservations if there aren't any
                        if (!valid_res) {
                            disable_field(enable_reservation, enable_reservation_label);
                            enable_reservation.attr('checked', false);
                        }

                        if (enable_reservation.is(":checked")) {
                                enable_field(reservation, reservation_label);
                                disable_time_controlls(time, time_label, start, start_label, end, end_label, enable_start, enable_start_label, enable_end, enable_end_label);
                                handle_reservation_change(queue, reservation);
                        } else {
                                disable_field(reservation, reservation_label);
                                enable_time_controlls(time, time_label, start, start_label, end, end_label, enable_start, enable_start_label, enable_end, enable_end_label);
                        }
                }
        }

        if (queue && exclusive) {

                if ((queue[0].value === "development") || (queue[0].value === "htc")) {
                        exclusive.attr('disabled', 'disabled');
                        exclusive.attr('checked', false);
                        enable_exclusive = false
                        exclusive_label.style.display = "none";
                } else if (queue[0].value === "gpgpu-1") {
                        exclusive.attr('disabled', 'disabled');
                        exclusive.attr('checked', true);
                        enable_exclusive = true
                        exclusive_label.style.display = "inline";
                } else {
                        exclusive.removeAttr('disabled');
                        exclusive_label.style.display = "inline";
                }

        }

	if (queue) {
		partition_limits(queue[0].value, enable_exclusive);
		queue.change(function () {
			// console.log("queue changed \n\r");
			
			if (exclusive) {
				if ((queue[0].value === "development") || (queue[0].value === "htc")) {
					exclusive.attr('disabled', 'disabled');
					exclusive.attr('checked', false);
					exclusive_label.style.display = "none";
					enable_exclusive = false
				} else if (queue[0].value === "gpgpu-1") {
					exclusive.attr('disabled', 'disabled');
					exclusive.attr('checked', true);
					enable_exclusive = true
					exclusive_label.style.display = "inline";
				} else {
					exclusive.removeAttr('disabled');
					exclusive_label.style.display = "inline";
				}

			}

			partition_limits(queue[0].value, enable_exclusive);
		})
	}

	// These are to make sure queues with multiple resources are handled
	// currently only applies to development queue since it has
	// 1 mic, 1 p100, 2 standard nodes
	// update if gpus change
	if (ngpus && queue) {
		ngpus.change(function () {
			partition_limits(queue[0].value, enable_exclusive);
		})
	}

	// update if cpus change
	if (ncpus && queue) {
		ncpus.change(function () {
			partition_limits(queue[0].value, enable_exclusive);
		})
	}

	// update if nodes changes
	if (nnodes && queue) {
		nnodes.change(function () {
			partition_limits(queue[0].value, enable_exclusive);
		})
	}

	// update if nodes changes
	if (nmem && queue) {
		nmem.change(function () {
			partition_limits(queue[0].value, enable_exclusive);
		})
	}

	// disable jupyter environments missing jupyter- lab
	if ($('#batch_connect_session_context_python_version').length > 0) {

		Array.from(document.querySelector("#batch_connect_session_context_python_version").options).forEach(function (option_element) {
			let option_value = option_element.value;
			if (!option_value.localeCompare("No Jupyter Lab")) {
				option_element.disabled = true;
			}
		});
	}

        // disable invalid queues if a reservation is selected
        if (reservation && enable_reservation) {
                reservation.change(function () {
                      handle_reservation_change(queue, reservation);
		});
	}

        // enable / disable time limits if check boxes change
        if (start_label) {
		enable_start.change(function() {
			//console.log("enable_start changed: " + enable_start.is(":checked")  + " \n\r");
			if (enable_start.is(":checked")) {
				enable_field(start, start_label);
			} else {
                                disable_field(start, start_label);
			}
		})
	}
	if (end_label) {
		enable_end.change(function() {
			//console.log("enable_end changed: " + enable_end.is(":checked")  + " \n\r");
			if (enable_end.is(":checked")) {
				enable_field(end, end_label);
			} else {
				disable_field(end, end_label);
			}
		})
	}
        if (reservation_label) {
                enable_reservation.change(function() {
                        if (enable_reservation.is(":checked")) {
                                enable_field(reservation, reservation_label);
                                handle_reservation_change(queue, reservation);
                                disable_time_controlls(time, time_label, start, start_label, end, end_label, enable_start, enable_start_label, enable_end, enable_end_label);
                        } else {
                                disable_field(reservation, reservation_label);
                                enable_list_options(queue[0]);
                                enable_time_controlls(time, time_label, start, start_label, end, end_label, enable_start, enable_start_label, enable_end, enable_end_label);
                        }
                })
        }


	// enable disable fields if exclusive is checked or not
	if (exclusive && queue) {
		exclusive.change(function() {
			enable_exclusive = exclusive.is(":checked");
			partition_limits(queue[0].value, enable_exclusive);

		})
	}


});

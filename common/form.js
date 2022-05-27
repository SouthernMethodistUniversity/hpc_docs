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
		gpu_label = document.querySelector("[for='batch_connect_session_context_bc_num_gpus']").closest('div.form-group');
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
		max_gpu = 1;
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
        if (enable_exclusive && (selected_queue !== "development")) {
        	gpu.val(max_gpu);
		cpus.val(max_cpu);
		mem.val(max_mem);
        }
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
        let enable_start;
	let start;
	let start_label;
	let enable_end;
	let end;
	let end_label;
        let exclusive;
	let exclusive_label;
        var enable_exclusive = false

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
		//console.log("enable_start: " + enable_start.is(":checked")  + " \n\r");
	}
	if ($('#start').length > 0) {
		start = $('#start');
	}
	if ($('#enable_end').length > 0) {
		enable_end = $('#enable_end');
		//console.log("enable_enable: " + enable_end.is(":checked")  + " \n\r");
	}
	if ($('#end').length > 0) {
		end = $('#end');
	}
	if ($('#enable_exclusive').length > 0) {
		exclusive = $('#enable_exclusive');
		enable_exclusive = exclusive.is(":checked");
		exclusive_label = document.querySelector("[for='batch_connect_session_context_use_exclusive']").closest('div.form-group');
	}

	// enable disable fields on page load
	if (start && enable_start) {
		start_label = document.querySelector("[for='batch_connect_session_context_start_time']").closest('div.form-group');
		if (start_label) {
			if (enable_start.is(":checked")) {
				start.removeAttr('disabled');
				start.show();	
				start_label.style.display = "inline";
			} else {
				start_label.style.display = "none";
				start.attr('disabled', 'disabled');
				start.hide();
			}
		}
	}

	if (end && enable_end) {
		end_label = document.querySelector("[for='batch_connect_session_context_end_time']").closest('div.form-group');
		if (end_label) {
			if (enable_end.is(":checked")) {
				end.removeAttr('disabled');
				end.show();	
				end_label.style.display = "inline";
			} else {
				end_label.style.display = "none";
				end.attr('disabled', 'disabled');
				end.hide();
			}
		}
	}

	if (queue && exclusive) {

		if (queue[0].value === "development") {
			exclusive.attr('disabled', 'disabled');
			exclusive.attr('checked', false);
			enable_exclusive = false
		} else if (queue[0].value === "gpgpu-1") {
			exclusive.attr('disabled', 'disabled');
			exclusive.attr('checked', true);
			enable_exclusive = true
		} else {
			exclusive.removeAttr('disabled');
		}

	}

	if (queue) {
		partition_limits(queue[0].value, enable_exclusive);
		queue.change(function () {
			// console.log("queue changed \n\r");
			
			if (exclusive) {
				if (queue[0].value === "development") {
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
				// console.log('Option value (disable) : ' + option_value);
				// console.log("\n\r");
				option_element.disabled = true;
			}
			// else {
			// 	console.log('Option value : ' + option_value);
			// 	console.log("\n\r");
			// }
		});
	}

        // enable / disable time limits if check boxes change
        if (start_label) {
		enable_start.change(function() {
			//console.log("enable_start changed: " + enable_start.is(":checked")  + " \n\r");
			if (enable_start.is(":checked")) {
				start.removeAttr('disabled');
				start.show();	
				start_label.style.display = "inline";
			} else {
				start_label.style.display = "none";
				start.attr('disabled', 'disabled');
				start.hide();
			}
		})
	}
	if (end_label) {
		enable_end.change(function() {
			//console.log("enable_end changed: " + enable_end.is(":checked")  + " \n\r");
			if (enable_end.is(":checked")) {
				end.removeAttr('disabled');
				end.show();	
				end_label.style.display = "inline";
			} else {
				end_label.style.display = "none";
				end.attr('disabled', 'disabled');
				end.hide();
			}
		})
	}

	// enable disable fields if exclusive is checked or not
	if (exclusive && queue) {
		exclusive.change(function() {
			console.log("exclusive changed: " + exclusive.is(":checked")  + " \n\r");
			enable_exclusive = exclusive.is(":checked");
			partition_limits(queue[0].value, enable_exclusive);

		})
	}


});

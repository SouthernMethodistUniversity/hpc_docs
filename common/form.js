'use strict'

/*
 * Function to handle partition limitations
 */
function partition_limits(selected_queue) {

	// Get Form Fields
	var time = $('#bc_num_hours');
	var cpus = $('#num_cpus');
	var mem = $('#num_mem');
	var gpu = $('#num_gpus');
        var node = $('#num_nodes');

	// Get Default Max Values
	var max_time = time.attr("max");
	var max_cpu = cpus.attr("max");
	var max_mem = mem.attr("max");
	var max_gpu = gpu.attr("max");
        var max_node = node.attr("max");

	if (selected_queue === "development") {
		max_time = 2;
		max_cpu = 36;
		max_mem = 250;
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
                max_mem = 20;
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

	// Handle Max Time Changes
	if (time.val() > max_time) {
		time.val(max_time)
	}
	time.attr({ "max": max_time });

	// Handle Max CPU Changes
	if (cpus.val() > max_cpu) {
		cpus.val(max_cpu)
	}
	cpus.attr({ "max": max_cpu });

	// Handle Max Mem Changes
	if (mem.val() > max_mem) {
		mem.val(max_mem)
	}
	mem.attr({ "max": max_mem });

	// Handle Max GPU Changes
	if (gpu.val() > max_gpu) {
		gpu.val(max_gpu)
	}
	gpu.attr({ "max": max_gpu });
	if (max_gpu === 0) {
		gpu.attr('disabled', 'disabled');
	}
	else {
		gpu.removeAttr('disabled');
	}
        // handle max nodes
        if (node.val() > max_node) {
           node.val(max_node)
        }
        node.attr({"max": max_node })
}

/*
 * Invoke the functions when the DOM is ready.
 */
$(document).ready(function () {

	// Set Default Partition
	$('select').find('option[value=interactive]').attr('selected', 'selected');

	// Handle Partition Specific Settings
	let queue = $('#batch_connect_session_context_custom_queue');
	partition_limits(queue[0].value);
	queue.change(function () {
		partition_limits(queue[0].value);
	})
});



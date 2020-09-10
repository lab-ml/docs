Installation & Setup
====================

.. currentmodule:: labml.lab

Lab
---

.. code-block:: console

    pip install labml

Create ``.labml.yaml`` file
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: yaml

	check_repo_dirty: true
	data_path: 'data'
	experiments_path: 'logs'
	analytics_path: 'analytics'
	web_api: 'TOKEN from web.lab-ml.com'
	web_api_frequency: 60
	web_api_verify_connection: true
	indicators:
	 -
	  class_name: Scalar
	  is_print: True
	  name: '*'

You need to create a ``.labml.yaml`` file at the root of your project.
The values will default to above so an empty file should work for most of the use cases.

	``check_repo_dirty``: If ``true``, before running an experiment it checks and aborts if there are any uncommitted changes

	``data_path``: The location of data files.	this can be accessed via :func:`labml.lab.get_data_path`.

	``experiments_path``: This is where all the experiment details such as logs, configs and checkpoints are saved. This can be accessed via :func:`labml.lab.get_experiments_path`.

	``analytics_path``: ⚠️ This is where Jupyter Notebooks for custom analytics will be saved. This is still experimental.

	``web_api``: The token from `web.lab-ml.com <https://web.lab-ml.com>_` or a url to a hosted
	`LabML App <https://github.com/lab-ml/app>`_.

	``web_api_frequency``: Interval in seconds to push stats to `LabML App <https://web.lab-ml.com>_`.

	``web_api_verify_connection``: Whether to verify SSL certificate of the app.
	You might want to set this to false if you self host and use an unverified SSL certificate.

	``indicators``: Use this to specify types of `indicators for tracker <tracker.html>`_.
	``class_name`` is the type of the indicator. ``is_print`` is whether to output
	the statistic to console and `LabML App <https://github.com/lab-ml/app>`_.
	``name`` can be a wildcard selector for indicator names. You can set these individually with
	the `tracker API <tracker.html>`_.



.. note::

	You can set these configurations with :func:`configure` as well.

Dashboard
-------------

.. code-block:: console

  pip install labml-dashboard


Navigate to the path of the project and run the following command to start the server.

.. code-block:: console

  labml dashboard



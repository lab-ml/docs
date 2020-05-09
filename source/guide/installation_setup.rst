Installation & Setup
====================

Lab
---

.. code-block:: console

    pip install machine_learning_lab

Create ``.lab.yaml`` file
^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: yaml

	check_repo_dirty: true
	data_path: 'data'
	experiments_path: 'logs'
	analytics_path: 'analytics'

You need to create a ``.lab.yaml`` file at the root of your project.
The values will default to above so an empty file should work for most of the use cases.

	``check_repo_dirty``: If ``true``, before running an experiment it checks and aborts if there are any uncommitted changes

	``data_path``: The location of data files.	this can be accessed via :func:`lab.get_data_path`.

	``experiments_path``: This is where all the experiment details such as logs, configs and checkpoints are saved. This can be accessed via :func:`lab.get_experiments_path`.

	``analytics_path``: ⚠️ This is where Jupyter Notebooks for custom analytics will be saved. This is still experimental.

.. note::

	You don't need the `.lab.yaml` file if you only use :mod:`lab.logger`.

Dashboard
-------------

.. code-block:: console

  pip install machine_learning_lab_dashboard


Navigate to the path of the project and run the following command to start the server.

.. code-block:: console

  lab dashboard



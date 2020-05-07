Installation & Setup
====================

Lab
---

.. code-block:: bash

    pip install machine_learning_lab

.. note::

    **Create a .lab.yaml file**

    An empty file at the root of the project should be enough. You can set project level configs for 'check_repo_dirty' and 'path' 'check_repo_dirty' and 'path'.

    Lab will store all experiment data in folder `logs/` relative to `.lab.yaml` file. If `path` is set in `.lab.yaml` then it will be stored in `[path]logs/` relative to `.lab.yaml` file.

    You don't need the `.lab.yaml` file if you only plan on using the logger.

Dashboard
-------------

.. code-block:: bash

  pip install machine_learning_lab_dashboard

Starting the server
-------------------

Navigate to the path of the project and run the following command to start the server.

.. code-block:: bash

  lab dashboard



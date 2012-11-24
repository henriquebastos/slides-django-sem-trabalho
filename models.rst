Relacione models sem *import*
-----------------------------

.. sourcecode:: python

    from django.db import models
    from project.app.models import OtherModel

    class MyModel(models.Model):
        other = models.ForeignKey(OtherModel)

Relacione models sem *import*
-----------------------------

.. sourcecode:: python

    from django.db import models

    class MyModel(models.Model):
        other = models.ForeignKey("OtherModel") # \o/

Choices
-------

.. container:: small

    .. sourcecode:: python

        class Uf(models.Model):
            abrev = models.CharField(max_length=2)   # RJ
            nome  = models.CharField(max_length=255) # Rio de Janeiro

        class Logradouro(models.Model):
            abrev = models.CharField(max_length=10)  # Av.
            nome  = models.CharField(max_length=255) # Avenida

        class Imovel(models.Model):
            uf = models.ForeignKey('Uf')
            logradouro = models.ForeignKey('Logradouro')
            ...

Choices
-------

.. container:: small

    .. sourcecode:: python

        UF = (
            ('RJ', 'Rio de Janeiro),
            ...
        )

        LOGRADOURO = (
            ('Av.', 'Avenida'),
            ...
        )

        class Imovel(models.Model):
            uf = models.CharField(max_length=2, choices=UF, db_index=True)
            logradouro = models.CharField(max_length=10, choices=LOGRADOURO)
            ...

Medo de mudar *Schema* não é motivo para usar MongoDB
-----------------------------------------------------

* Use o South;
* Domine o funcionamento do South;

Desenvolvendo com o South
-------------------------

* Cuidado para não acumular migrações irrelevantes.
* Use ``SOUTH_TEST_MIGRATE=False`` para experimentar mudanças de modelo.


Proxy Models
------------

::

    Dado que eu tenho um site de cupons
    Quando eu visitar a home
    Eu quero ver uma uma dropdown contendo
        o nomes das cidades
        e a quantidade de cupons
        considerando apenas cidades com cupons
        cujas datas de expiração seja posterior a hoje.

Proxy Models
------------
.. container:: small

    .. sourcecode:: python

        class MenuManager(models.Manager):
            def get_queryset(self):
                qs = super(MenuManager, self).get_queryset()
                qs = qs.filter(...)
                return qs

        class Menu(ModelCupom):
            objects = MenuManager()

            class Meta:
                proxy = True

        # É só usar Menu.objects.all() no template.

Encapsule queries frequentes
----------------------------

``pip install django-model-utils``

.. container:: small

    .. sourcecode:: python

        from model_utils.managers import PassThroughManager
        from django.models.query import QuerySet

        class TodoQuerySet(QuerySet):
            def incomplete(self):
                return self.filter(is_done=False)

            def high_priority(self):
                return self.filter(priority=1)

        class Todo(models.Model):
            content = models.CharField(max_length=100)
            # other fields go here..

            objects = PassThroughManager.for_queryset_class(TodoQuerySet)()

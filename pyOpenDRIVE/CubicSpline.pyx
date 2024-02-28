# distutils: language=c++

from pyOpenDrive cimport XmlNode

cdef class PyCubicSpline:
    def __cinit__(self):
        self.c_self = make_shared[CubicSpline]()
# distutils: language=c++

cdef extern from "../src/Lane.cpp":
    pass

from libcpp.vector cimport vector
from libcpp.map cimport map
from libcpp.set cimport set
from libcpp.string cimport string
from libcpp cimport bool
from libcpp.memory cimport make_shared, shared_ptr

from pyOpenDrive.CubicSpline cimport CubicSpline
from pyOpenDrive.RoadMark cimport RoadMark, RoadMarkGroup

cdef extern from "Lane.h" namespace "odr":
    cdef cppclass HeightOffset:
        HeightOffset(double inner, double outer)

        double inner
        double outer

    cdef cppclass LaneKey:
        LaneKey(string road_id, double lanesection_s0, int lane_id)
        string to_string() const

        string road_id
        double lanesection_s0
        int lane_id

    cdef cppclass Lane:
        Lane(string road_id, double lanesection_s0, int id, bool level, string type) except +

        vector[RoadMark] get_roadmarks(const double s_start, const double s_end) const

        LaneKey key
        int id
        bool level
        int predecessor
        int successor
        string type

        CubicSpline lane_width
        CubicSpline outer_border
        CubicSpline inner_border

        map[double, HeightOffset] s_to_height_offset
        set[RoadMarkGroup] roadmark_groups

cdef class PyLane:
    cdef shared_ptr[Lane] c_self
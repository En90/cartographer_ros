-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "unilidar_imu",
  published_frame = "odom",
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false, 
  use_pose_extrapolator = true,
  use_odometry = true,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 0,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 0.5,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-2,
  trajectory_publish_period_sec = 30e-2,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

TRAJECTORY_BUILDER_3D.num_accumulated_range_data = 1
TRAJECTORY_BUILDER_3D.voxel_filter_size = 0.15
TRAJECTORY_BUILDER_3D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 15
TRAJECTORY_BUILDER_3D.max_range = 20
TRAJECTORY_BUILDER_3D.min_range = 0.7
TRAJECTORY_BUILDER_3D.submaps.high_resolution = 0.15
TRAJECTORY_BUILDER_3D.submaps.low_resolution = 0.75
TRAJECTORY_BUILDER_3D.submaps.num_range_data = 250
-- TRAJECTORY_BUILDER_3D.high_resolution_adaptive_voxel_filter.min_num_points = 60
-- TRAJECTORY_BUILDER_3D.high_resolution_adaptive_voxel_filter.max_range = 3
-- TRAJECTORY_BUILDER_3D.high_resolution_adaptive_voxel_filter.max_length = 5
-- TRAJECTORY_BUILDER_3D.low_resolution_adaptive_voxel_filter.min_num_points = 100
-- TRAJECTORY_BUILDER_3D.low_resolution_adaptive_voxel_filter.max_range = 10
-- TRAJECTORY_BUILDER_3D.low_resolution_adaptive_voxel_filter.max_length = 7
-- TRAJECTORY_BUILDER_3D.ceres_scan_matcher.only_optimize_yaw = true
TRAJECTORY_BUILDER_3D.use_online_correlative_scan_matching = true
--TRAJECTORY_BUILDER_3D.motion_filter.max_distance_meters = 0.1
--TRAJECTORY_BUILDER_3D.motion_filter.max_time_seconds = 0.5
--TRAJECTORY_BUILDER_3D.motion_filter.max_angle_radians = 0.004
--TRAJECTORY_BUILDER_3D.real_time_correlative_scan_matcher = {
--  linear_search_window = 0.15,
--  angular_search_window = math.rad(1),
--  translation_delta_cost_weight = 1e-1,
--  rotation_delta_cost_weight = 1e-1,
--}

TRAJECTORY_BUILDER.pure_localization_trimmer = {
  max_submaps_to_keep = 3,
}

MAP_BUILDER.use_trajectory_builder_3d = true
MAP_BUILDER.num_background_threads = 2
POSE_GRAPH.optimization_problem.huber_scale = 5e2
-- POSE_GRAPH.optimize_every_n_nodes = 0
POSE_GRAPH.optimize_every_n_nodes = 10
POSE_GRAPH.constraint_builder.sampling_ratio = 0.2
POSE_GRAPH.optimization_problem.ceres_solver_options.max_num_iterations = 60
POSE_GRAPH.constraint_builder.min_score = 0.54
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.45 --0.59
POSE_GRAPH.constraint_builder.max_constraint_distance = 10
POSE_GRAPH.global_sampling_ratio = 0.15
--POSE_GRAPH.constraint_builder.ceres_scan_matcher_3d.only_optimize_yaw = true
--POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher_3d.branch_and_bound_depth = 8
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher_3d.linear_xy_search_window = 1.5
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher_3d.linear_z_search_window = 0.25
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher_3d.angular_search_window = math.rad(15.)
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher_3d.min_rotational_score = 0.75
--POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher_3d.min_low_resolution_score = 0.6
--POSE_GRAPH.constraint_builder.ceres_scan_matcher_3d.occupied_space_weight_0 = 6
--POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 2e5 --1e5
--POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 2e5 --1e5
--POSE_GRAPH.optimization_problem.odometry_translation_weight = 1e5 --1e5
--POSE_GRAPH.optimization_problem.odometry_rotation_weight = 1e4 --1e5
POSE_GRAPH.optimization_problem.use_online_imu_extrinsics_in_3d = false
POSE_GRAPH.optimization_problem.huber_scale = 7

POSE_GRAPH.log_residual_histograms = false
POSE_GRAPH.optimization_problem.log_solver_summary = false
POSE_GRAPH.constraint_builder.log_matches = false

return options

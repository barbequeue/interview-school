Rails.application.routes.draw do
  resources :sections
  resources :students do
    resources :student_sections, only: [:new, :create, :destroy], shallow: true
  end
  resources :classrooms
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

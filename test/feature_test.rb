require 'test_helper'

class FeatureInheritanceTest < BaseTest
  class AlbumForm < Reform126::Form
    # include Reform126::Form::ActiveModel
    # include Coercion
    # include MultiParameterAttributes

    property :band do
      property :label do
      end
    end
  end

  subject { AlbumForm.new(Album.new(nil, nil, nil, Band.new(Label.new))) }

  # it { subject.class.include?(Reform126::Form::ActiveModel) }
  # it { subject.class.include?(Reform126::Form::Coercion) }
  # it { subject.is_a?(Reform126::Form::MultiParameterAttributes) }

  # it { subject.band.class.include?(Reform126::Form::ActiveModel) }
  # it { subject.band.is_a?(Reform126::Form::Coercion) }
  # it { subject.band.is_a?(Reform126::Form::MultiParameterAttributes) }

  # it { subject.band.label.is_a?(Reform126::Form::ActiveModel) }
  # it { subject.band.label.is_a?(Reform126::Form::Coercion) }
  # it { subject.band.label.is_a?(Reform126::Form::MultiParameterAttributes) }
end
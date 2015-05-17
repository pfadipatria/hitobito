# encoding: utf-8

#  Copyright (c) 2012-2014, Jungwacht Blauring Schweiz, Pfadibewegung Schweiz.
#  This file is part of hitobito and licensed under the Affero General Public
#  License version 3 or later. See the COPYING file at the top-level directory
#  or at https://github.com/hitobito/hitobito.


module Export::Csv
  # The base class for all the different csv export files.
  class Base

    class_attribute :model_class, :row_class
    self.row_class = Row

    attr_reader :list

    class << self
      def export(*args)
        Export::Csv::Generator.new(new(*args)).csv
      end
    end

    def initialize(list)
      @list = list
    end

    def to_csv(generator)
      generator << labels
      list.each do |entry|
        generator << values(entry)
      end
    end

    # The list of all attributes exported to the csv.
    # overridde either this or #attribute_labels
    def attributes
      attributes = sort_attributes

      i = 0
      while i < attributes.size do
        if attributes[i].to_s.include? "roles"
          tmp = attributes[i]
          attributes.delete_at(i)
          attributes.push(tmp)
          break
        end
        i = i +1
      end

      puts attributes
      attributes

    end

    # A hash of all attributes mapped to their labels exported to the csv.
    # overridde either this or #attributes
    def attribute_labels
      #this
      @attribute_labels ||= build_attribute_labels
    end

    # List of all lables.
    def labels
      attributes = sort_labels

      i = 0
      while i < attributes.size do
        if attributes[i].to_s.include? "Rollen"
          tmp = attributes[i]
          attributes.delete_at(i)
          attributes.push(tmp)
          break
        end
        i = i +1
      end

      puts attributes
      attributes


    end


    def sort_labels

      attributes = attribute_labels.values
      sortedAttributeLabels = Array.new(attributes.size)
      i = 0;
      j = 0;
      while i < attributes.size do
        if attributes[i].to_s.include? "Anrede"
          sortedAttributeLabels[0] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Vorname"
          sortedAttributeLabels[1] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Nachname"
          sortedAttributeLabels[2] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Geschlecht"
          sortedAttributeLabels[3] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Firmenname"
          sortedAttributeLabels[4] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Pfadiname"
          sortedAttributeLabels[5] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Firma"
          sortedAttributeLabels[6] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Haupt-E-Mail"
          sortedAttributeLabels[7] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Adresse"
          sortedAttributeLabels[8] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "PLZ"
          sortedAttributeLabels[9] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Ort"
          sortedAttributeLabels[10] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Land"
          sortedAttributeLabels[11] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Geburtstag"
          sortedAttributeLabels[12] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Zusätzliche Angaben"
          sortedAttributeLabels[13] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Beruf"
          sortedAttributeLabels[14] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Titel"
          sortedAttributeLabels[15] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Schulklasse"
          sortedAttributeLabels[16] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Eintrittsdatum"
          sortedAttributeLabels[17] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Austrittsdatum"
          sortedAttributeLabels[18] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "J+S Personennummer"
          sortedAttributeLabels[19] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Korrespondenzsprache"
          sortedAttributeLabels[20] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "Geschwister"
          sortedAttributeLabels[21] = attributes[i]
          attributes[i] = nil
        elsif attributes[i].to_s.include? "PBS Personennummer"
          sortedAttributeLabels[22] = attributes[i]
          attributes[i] = nil
        end
        i = i+1
      end

      sortedAttributeLabels = sortedAttributeLabels.compact
      attributes = attributes.compact
      while j < attributes.size do
        sortedAttributeLabels.push(attributes[j])
        j = j+1
      end

      sortedAttributeLabels
      end

    def sort_attributes

      attributes = attribute_labels.values
      attributesKeys = attribute_labels.keys
      sortedAttributes = Array.new(attributes.size)
      i = 0;
      j = 0;
      while i < attributes.size do
        if attributes[i].to_s.include? "Anrede"
          sortedAttributes[0] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Vorname"
          sortedAttributes[1] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Nachname"
          sortedAttributes[2] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Geschlecht"
          sortedAttributes[3] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Firmenname"
          sortedAttributes[4] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Pfadiname"
          sortedAttributes[5] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Firma"
          sortedAttributes[6] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Haupt-E-Mail"
          sortedAttributes[7] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Adresse"
          sortedAttributes[8] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "PLZ"
          sortedAttributes[9] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Ort"
          sortedAttributes[10] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Land"
          sortedAttributes[11] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Geburtstag"
          sortedAttributes[12] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Zusätzliche Angaben"
          sortedAttributes[13] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Beruf"
          sortedAttributes[14] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Titel"
          sortedAttributes[15] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Schulklasse"
          sortedAttributes[16] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Eintrittsdatum"
          sortedAttributes[17] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Austrittsdatum"
          sortedAttributes[18] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "J+S Personennummer"
          sortedAttributes[19] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Korrespondenzsprache"
          sortedAttributes[20] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "Geschwister"
          sortedAttributes[21] = attributesKeys[i]
          attributesKeys[i] = nil
        elsif attributes[i].to_s.include? "PBS Personennummer"
          sortedAttributes[22] = attributesKeys[i]
          attributesKeys[i] = nil
        end
        i = i+1
      end

      sortedAttributes = sortedAttributes.compact
      attributesKeys = attributesKeys.compact

      while j < attributesKeys.size do
        sortedAttributes.push(attributesKeys[j])
        j = j+1
      end

      sortedAttributes


    end
    private

    def build_attribute_labels
      attributes.each_with_object({}) do |attr, labels|
        labels[attr] = attribute_label(attr)
      end
    end

    def attribute_label(attr)
      human_attribute(attr)
    end

    def human_attribute(attr)
      model_class.human_attribute_name(attr)
    end

    def values(entry)
      row = row_class.new(entry)
      attributes.collect { |attr| row.fetch(attr) }
    end

  end

end

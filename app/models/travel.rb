class Travel < ApplicationRecord
    validate :group_size_limit

    private 

    def group_size_limit
        if people && people > 10
            errors.add(:people, "Numero massimo di partecipanti raggiunto")
        end
    end
end
